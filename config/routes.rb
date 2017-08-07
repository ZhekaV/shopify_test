require 'sidekiq/web'
Rails.application.routes.draw do
  root to: 'home#index'

  mount ShopifyApp::Engine, at: '/'
  mount Sidekiq::Web => '/sidekiq'

  # get 'export', to: 'products#export'
  get 'import', to: 'products#import'
  get 'xml', to: 'products#xml', format: 'xml'
end
