require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "should add unique product to cart" do
    cart = carts(:three)
    product = products(:ruby)

    line_item = cart.add_product(product)
    line_item.save
    assert_equal 1, cart.line_items.count
  end

  test "should add duplicate product to cart" do
    cart = carts(:three)
    product = products(:ruby)

    line_item1 = cart.add_product(product)
    line_item1.save
    
    line_item2 = cart.add_product(product)
    line_item2.save
    
    assert_equal 1, cart.line_items.count
    assert_equal 2, line_item2.quantity
  end
end
