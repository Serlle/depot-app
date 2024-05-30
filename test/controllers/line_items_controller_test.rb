require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    follow_redirect!

    assert_select 'h2', 'Your Cart'
    assert_select 'td', "Programing Ruby 1.9"
  end

  test "should create line_item via 'Add to Cart' button via turbo-stream" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:ruby).id },
      as: :turbo_stream
    end

    assert_response :success
    assert_match /<tr class="line-item-highlight">/, @response.body
  end

  test "should create line_item via image click via turbo-stream" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:ruby).id },
      as: :turbo_stream
    end

    assert_response :success
    assert_match /<tr class="line-item-highlight">/, @response.body
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test "should destroy line_item" do
    assert_difference("LineItem.count", -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to store_index_url
  end

  test "should destroy line_item and hide visit via turbo-stream" do
    assert_difference("LineItem.count", -1) do
      delete line_item_url(@line_item),
      as: :turbo_stream
    end

    assert_response :success
    assert_match /<div id="cart">/, @response.body
    assert_match /<div id="visit">/, @response.body
  end

  test "should remove one line_item" do
    @line_item.update(quantity: 3)

    assert_difference('LineItem.count', 0) do
      delete line_item_url(@line_item)
    end
    
    @line_item.reload

    assert_equal 2, @line_item.quantity
    assert_redirected_to store_index_url
  end

  test "should remove one line_item and hide visit via turbo-stream" do
    @line_item.update(quantity: 3)

    assert_difference('LineItem.count', 0) do
      delete line_item_url(@line_item),
      as: :turbo_stream
    end
    
    @line_item.reload

    assert_response :success
    assert_equal 2, @line_item.quantity
    assert_match /<div id="line_item">/, @response.body
    assert_match /<tr class="line-item-highlight">/, @response.body
    assert_match /<div id="visit">/, @response.body
  end
end
