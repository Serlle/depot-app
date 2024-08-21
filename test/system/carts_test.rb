require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  test "should show the cart with Add to Cart button" do
    visit store_index_url
    click_on 'Add to Cart', match: :first

    assert has_css? 'div.bg-white'
  end

  test "should hide the cart with Empty Cart button" do
    visit store_index_url
    click_on 'Add to Cart', match: :first
    click_on 'Empty Cart'
    
    assert_selector "p", text: "Your cart is currently empty"
  end

  test "should line item highlight" do
    visit store_index_url
    click_on 'Add to Cart', match: :first

    assert has_css? 'tr.line-item-highlight'
  end
end
