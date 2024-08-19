class AddPaymentTypeToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :payment_type, foreign_key: true
  end
end
