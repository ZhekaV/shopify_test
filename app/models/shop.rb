class Shop < ApplicationRecord
  include ShopifyApp::Shop
  include ShopifyApp::SessionStorage

  has_many :products
  has_many :collections
end
