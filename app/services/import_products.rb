class ImportProducts
  prepend SimpleCommand
  include SaveCollections
  include SaveProducts
  include SaveRelations

  DELAY = 1

  def initialize(shop_id)
    @shop = Shop.find shop_id
  end

  def call
    clear_cache
    open_session
    save_products
    delete_nonexistent_products
    save_custom_collections
    save_smart_collections
    delete_nonexistent_collections
    save_relations
    close_session
  end

  private

  attr_reader :shop, :session, :cache_namespace

  def clear_cache
    @cache_namespace = "/shops/#{shop.id}"
    Rails.cache.delete("#{cache_namespace}/products")
    Rails.cache.delete("#{cache_namespace}/collections")
  end

  def add_to_cache(kind, id)
    nms = "#{cache_namespace}/#{kind}"
    Rails.cache.write(nms, (Rails.cache.read(nms) || []) << id)
  end

  def open_session
    @session = ShopifyAPI::Session.new(shop.shopify_domain, shop.shopify_token)
    ShopifyAPI::Base.activate_session(@session)
  end

  def close_session
    ShopifyAPI::Base.clear_session
  end

  def request_wrapper
    return unless block_given?
    yield
  rescue ActiveResource::ClientError => exception
    return raise exception unless exception&.response&.code == '429'
    sleep(DELAY)
    request_wrapper { yield }
  rescue StandardError => exception
    raise exception
  end

  # TODO: paginate resources
  # TODO: replace it with plain json request for speed & memory improvements
  def shopify_request(resources_kind)
    request_wrapper do
      "ShopifyAPI::#{resources_kind}".constantize.find(:all, params: { limit: 250 })
    end
  end

  def products
    shopify_request('Product')
  end

  def custom_collections
    shopify_request('CustomCollection')
  end

  def smart_collections
    shopify_request('SmartCollection')
  end

  def collects
    shopify_request('Collect')
  end
end
