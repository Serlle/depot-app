class OrderMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'

  def received(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end

  def ship_date_updated(order)
    @order = order
    mail(to: @order.email, subject: 'Your order ship date has been updated')
  end
end
