require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test 'received' do
    mail = OrderMailer.received(orders(:one))
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
    assert_equal ['dave@example.org'], mail.to
    assert_equal ['depot@example.com'], mail.from
    assert_match(/1 x Programing Ruby 1.9/, mail.body.encoded)
  end

  test 'shipped' do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal 'Pragmatic Store Order Shipped', mail.subject
    assert_equal ['dave@example.org'], mail.to
    assert_equal ['depot@example.com'], mail.from
    assert_match %r{
      <td[^>]*>1<\/td>\s*
      <td>&times;<\/td>\s*
      <td[^>]*>\s*Programing\sRuby\s1.9\s*</td>
    }x, mail.body.encoded
  end

  test 'ship date updated' do
    order = orders(:one)
    order.update(ship_date: Time.zone.now + 10.days)
    mail = OrderMailer.ship_date_updated(order)
    assert_equal 'Your order ship date has been updated', mail.subject
    assert_equal [order.email], mail.to
    assert_equal ['depot@example.com'], mail.from
    assert_match /Your order's ship date has been updated to/, mail.body.encoded
  end
end
