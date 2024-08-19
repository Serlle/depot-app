json.title_product line_item.product.title
json.extract! line_item, :id, :product_id, :quantity, :price_product, :created_at, :updated_at
json.url line_item_url(line_item, format: :json)
