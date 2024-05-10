class AddPriceProductToLineItems < ActiveRecord::Migration[7.0]
  def change
    add_column :line_items, :price_product, :decimal, precision: 8, scale: 2
  end
end
