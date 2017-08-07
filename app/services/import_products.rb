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

  # TODO: paginate resources
  # TODO: rescue 429
  # TODO: replace it with plain json request for speed & memory improvements
  def shopify_request(resources_kind)
    ShopifyAPI::Session.temp(
      shop.shopify_domain,
      shop.shopify_token
    ) { "ShopifyAPI::#{resources_kind}".constantize.find(:all, params: { limit: 250 }) }
  end

  def products
    shopify_request('Product')
  end

  def collects
    shopify_request('Collect')
  end

  def custom_collections
    shopify_request('CustomCollection')
  end

  def smart_collections
    shopify_request('SmartCollection')
  end
end
