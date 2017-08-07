class Collection < ApplicationRecord
  extend Enumerize

  belongs_to :shop
  has_many :collects, class_name: 'Collect', primary_key: 'shopify_id', foreign_key: 'collection_shopify_id'
  has_many :products, through: :collects

  enumerize :kind, in: %i[smart custom]
end
