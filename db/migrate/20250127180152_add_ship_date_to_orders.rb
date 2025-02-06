class AddShipDateToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :ship_date, :datetime, null: true
  end
end
