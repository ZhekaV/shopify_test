source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails'

gem 'activerecord-import'
gem 'coffee-rails'
gem 'enumerize'
gem 'jbuilder'
gem 'kaminari'
gem 'pg'
gem 'puma'
gem 'redis'
gem 'redis-namespace'
gem 'sass-rails'
gem 'shopify_app'
gem 'sidekiq'
gem 'simple_command'
gem 'sinatra', require: false
gem 'slim'
gem 'turbolinks'
gem 'uglifier'

group :development, :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'listen'
  gem 'pronto'
  gem 'pronto-flay', require: false
  gem 'pronto-rails_best_practices', require: false
  gem 'pronto-rubocop', require: false
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubycritic'
  gem 'spring'
  gem 'spring-watcher-listen'
end
