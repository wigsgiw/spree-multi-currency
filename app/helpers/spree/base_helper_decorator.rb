module Spree::BaseHelper
  def order_price(order, options={})
    options.assert_valid_keys(:format_as_currency, :show_vat_text, :show_price_inc_vat)
    options.reverse_merge! :format_as_currency => true, :show_vat_text => true
    options[:show_vat_text] = Spree::Config[:show_price_inc_vat]
    amount = Currency.convert(order.item_total, order.currency, Currency.current.char_code)
    Order.find(order.id).update_attribute("currency", Currency.current.char_code)
    Order.find(order.id).update_attribute("item_total", amount)
    options.delete(:format_as_currency) ? number_to_currency(amount) : amount
  end
end
