json.product do
  json.title @product.title
  json.latest_order do
    if @latest_order
      json.id @latest_order.id
      json.address @latest_order.address
      json.updated_at @latest_order.updated_at
      json.payment_type @latest_order.payment_type.name
      json.line_items @latest_order.line_items, partial: 'line_items/line_item', as: :line_item
    end
  end

  json.orders @product.orders, partial: 'orders/order', as: :order
end