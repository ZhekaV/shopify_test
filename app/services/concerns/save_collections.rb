module SaveCollections
  extend ActiveSupport::Concern

  def save_custom_collections
    @current_kind = :custom
    custom_collections.each do |collection|
      @current_collection = collection
      @persisted_collection = Collection.find_by(shopify_id: current_collection.id)
      next if persisted_collection && persisted_collection.updated_at > current_collection.updated_at
      proccess_collection
    end
  end

  def save_smart_collections
    @current_kind = :smart
    smart_collections.each do |collection|
      @current_collection = collection
      @persisted_collection = Collection.find_by(shopify_id: current_collection.id)
      next if persisted_collection && persisted_collection.updated_at > current_collection.updated_at
      proccess_collection
    end
  end

  private

  attr_reader :current_kind, :current_collection, :persisted_collection

  def proccess_collection
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
end
