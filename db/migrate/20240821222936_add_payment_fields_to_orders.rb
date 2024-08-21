class AddPaymentFieldsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :routing_number, :string, null: true
    add_column :orders, :account_number, :string, null: true
    add_column :orders, :credit_card_number, :string, null: true
    add_column :orders, :expiration_date, :string, null: true
    add_column :orders, :po_number, :string, null: true
  end
end
