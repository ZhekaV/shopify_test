class Product < ApplicationRecord
  belongs_to :shop
  has_many :variants
  has_many :collects, class_name: 'Collect', primary_key: 'shopify_id', foreign_key: 'product_shopify_id'
  has_many :collections, through: :collects
end
