class ImportProducts
  prepend SimpleCommand

  def initialize(shop_id)
    @shop = Shop.find shop_id
  end

  def call
    products
  end

  private

  attr_reader :shop

  # TODO: paginate products
  def products
    @products ||= ShopifyAPI::Session.temp(shop.shopify_domain, shop.shopify_token) { ShopifyAPI::Product.find(:all, params: { limit: 50 }) }
  end
end
