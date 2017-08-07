class Shop < ApplicationRecord
  include ShopifyApp::Shop
  include ShopifyApp::SessionStorage

  has_many :products, dependent: :delete_all
  has_many :collections, dependent: :delete_all
  has_many :collects, dependent: :delete_all
end
