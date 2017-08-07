module SaveRelations
  extend ActiveSupport::Concern

  def save_relations
    shop.collects.delete_all
    shop_id = shop.id
    collection_product = collects.map { |c| { shop_id: shop_id, collection_shopify_id: c.collection_id, product_shopify_id: c.product_id } }
    Collect.import collection_product, validate: false
  end
end
