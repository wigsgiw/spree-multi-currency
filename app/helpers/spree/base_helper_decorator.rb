Spree::BaseHelper.class_eval do
  def order_price(order, options={})
    options.assert_valid_keys(:format_as_currency, :show_vat_text, :show_price_inc_vat)
    options.reverse_merge! :format_as_currency => true, :show_vat_text => true, :show_vat_text => Spree::Config[:show_price_inc_vat]
    ammount = Currency.convert(order.item_total, Currency.basic, Currency.current.char_code)
    ammount += Calculator::Vat.calculate_tax(order) if Spree::Config[:show_price_inc_vat]
    options.delete(:format_as_currency) ? number_to_currency(amount) : amount
  end
end
