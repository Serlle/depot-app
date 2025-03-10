class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_isnt_empty, only: %i[new]
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_item_from_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        ChargeOrderJob.perform_later(@order, pay_type_params.to_h)
        format.html { redirect_to store_index_url, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      old_ship_date = @order.ship_date

      if @order.update(order_update_params)
        OrderMailer.ship_date_updated(@order).deliver_later if old_ship_date != @order.ship_date
        format.html { redirect_to order_url(@order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def ensure_cart_isnt_empty
    redirect_to store_index_url, notice: 'Your cart is empty' if @cart.line_items.empty?
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :payment_type_id)
  end

  def pay_type_params
    payment_type_name = PaymentType.name_for(order_params[:payment_type_id].to_i)

    if payment_type_name == 'Credit card'
      params.require(:order).permit(:credit_card_number, :expiration_date)
    elsif payment_type_name == 'Check'
      params.require(:order).permit(:routing_number, :account_number)
    elsif payment_type_name == 'Purchase order'
      params.require(:order).permit(:po_number)
    else
      {}
    end
  end

  def order_update_params
    order_params.merge(params.require(:order).permit(:ship_date))
  end
end
