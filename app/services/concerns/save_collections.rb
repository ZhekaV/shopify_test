module SaveCollections
  extend ActiveSupport::Concern

  def save_custom_collections
    @current_kind = :custom
    proccess_collections(custom_collections)
  end

  def save_smart_collections
    @current_kind = :smart
    proccess_collections(smart_collections)
  end

  private

  attr_reader :current_kind, :current_collection, :persisted_collection

  def proccess_collections(collections)
    collections.each do |collection|
      @current_collection = collection
      add_to_cache('collections', current_collection.id)
      @persisted_collection = Collection.find_by(shopify_id: current_collection.id)
      next if persisted_collection && persisted_collection.updated_at > current_collection.updated_at
      create_collection
    end
  end

  def create_collection
    persisted_collection.delete if persisted_collection.present?
    Collection.create(
      current_collection.attributes.slice(:kind, :handle, :title, :body_html, :sort_order, :template_suffix, :published_scope).merge(
        shop:               shop,
        shopify_id:         current_collection.id,
        shopify_updated_at: current_collection.updated_at,
        kind:               current_kind
      )
    )
  end

  def delete_nonexistent_collections
    shop.collections.where.not(shopify_id: Rails.cache.read("#{cache_namespace}/collections").compact).delete_all
  end
end
