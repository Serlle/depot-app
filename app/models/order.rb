require 'active_model/serializers/xml'
require 'pago'

class Order < ApplicationRecord
  include ActiveModel::Serializers::Xml

  has_many :line_items, dependent: :destroy
  belongs_to :payment_type
  validates :name, :address, :email, presence: true

  def add_line_item_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def charge!(pay_type_params)
    payment_details = {}
    payment_method = nil
    payment_type_name = PaymentType.name_for(payment_type_id.to_i)

    case payment_type_name
    when 'Check'
      payment_method = :check
      # Save in the db
      self.routing_number = pay_type_params[:routing_number]
      self.account_number = pay_type_params[:account_number]

      # this is to the API Pago
      payment_details[:routing] = pay_type_params[:routing_number]
      payment_details[:account] = pay_type_params[:account_number]
    when 'Credit card'
      payment_method = :credit_card
      # Save in the db
      self.credit_card_number = pay_type_params[:credit_card_number]
      self.expiration_date = pay_type_params[:expiration_date]

      # this is to the API Pago
      month, year = pay_type_params[:expiration_date].split('/')
      payment_details[:cc_num] = pay_type_params[:credit_card_number]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year
    when 'Purchase order'
      payment_method = :po
      # Save in the db
      self.po_number = pay_type_params[:po_number]

      # this is to the API Pago
      payment_details[:po_num] = pay_type_params[:po_number]
    end

    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )

    raise payment_result.error unless payment_result.succeeded?

    OrderMailer.received(self).deliver_later
  end
end
