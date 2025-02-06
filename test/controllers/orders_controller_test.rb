require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "requires item in cart" do
    get new_order_url
    assert_redirected_to store_index_url
    assert_equal 'Your cart is empty', flash[:notice]
  end

  test "should get new" do
    post line_items_url, params: { product_id: products(:ruby).id }
    follow_redirect!
    
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    @cart_id = carts(:one).id
    @payment_type_id = payment_types(:two).id

    post line_items_url, params: { product_id: products(:ruby).id, cart_id: @cart_id }
    follow_redirect!
    get new_order_url

    assert_difference("Order.count") do
      post orders_url, params: { 
        order: { 
          name: @order.name,
          address: @order.address,
          email: @order.email, 
          payment_type_id: @payment_type_id
        }
      }
    end

    assert_redirected_to store_index_url
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    new_ship_date = Time.zone.now + 10.days
    patch order_url(@order), params: { 
      order: { 
        address: @order.address, 
        email: @order.email, 
        name: @order.name, 
        payment_type: @order.payment_type_id,
        ship_date: new_ship_date
      }
    }
    assert_redirected_to order_url(@order)
    @order.reload
    assert_equal new_ship_date.to_i, @order.ship_date.to_i

    # Chek that the email was sent
    assert_enqueued_emails 1 do
      OrderMailer.ship_date_updated(@order).deliver_later
    end
  end

  test "should destroy order" do
    assert_difference("Order.count", -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
