xml.product do
  xml.id @product.id
  xml.title @product.title

  xml.latest_order do
    if @latest_order
      xml.id @latest_order.id
      xml.address @latest_order.address
      xml.updated_at @latest_order.updated_at
      xml.payment_type @latest_order.payment_type.name

      xml.line_items do
        @latest_order.line_items.each do |item|
          xml.line_item do
            xml.id item.id
            xml.quantity item.quantity
            xml.total_price item.total_price
            xml.product do
              xml.id item.product.id
              xml.title item.product.title
            end
          end
        end
      end
    end
  end

  xml.orders do
    @product.orders.each do |order|
      xml.order do
        xml.id order.id
        xml.address order.address
        xml.updated_at order.updated_at
        xml.payment_type order.payment_type.name

        xml.line_items do
          order.line_items.each do |item|
            xml.line_item do
              xml.id item.id
              xml.quantity item.quantity
              xml.total_price item.total_price
              xml.product do
                xml.id item.product.id
                xml.title item.product.title
              end
            end
          end
        end
      end
    end
  end
end
