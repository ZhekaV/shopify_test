Rails.application.routes.draw do
  root to: 'home#index'
  mount ShopifyApp::Engine, at: '/'

  get 'export', to: 'products#export'
  get 'import', to: 'products#import'
  get 'xml', to: 'products#xml', format: 'xml'
end
