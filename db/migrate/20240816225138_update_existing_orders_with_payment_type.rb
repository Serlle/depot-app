class UpdateExistingOrdersWithPaymentType < ActiveRecord::Migration[7.0]
  def up
    # Check if the pay_type column exists
    # Before enum on order
    # enum pay_type: {
    #   "Check"          => 0,
    #   "Credit card"    => 1,
    #   "Purchase order" => 2
    # }

    if column_exists?(:orders, :pay_type)
      pay_type_mapping = {
        0 => PaymentType.find_by(name: 'Check').id,
        1 => PaymentType.find_by(name: 'Credit card').id,
        2 => PaymentType.find_by(name: 'Purchase order').id
      }

      Order.find_each do |order|
        if pay_type_mapping[order.pay_type]
          order.update(payment_type_id: pay_type_mapping[order.pay_type])
        end
      end
    end
  end

  # def down
  #   Order.update_all(payment_type_id: nil)
  # end
end
