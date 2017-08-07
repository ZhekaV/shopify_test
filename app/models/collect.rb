class Collect < ApplicationRecord
  belongs_to :shop
  belongs_to :product, class_name: 'Product', primary_key: 'shopify_id', foreign_key: 'product_shopify_id'
  belongs_to :collection, class_name: 'Collection', primary_key: 'shopify_id', foreign_key: 'collection_shopify_id'
end
