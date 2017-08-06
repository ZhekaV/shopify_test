source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails'

gem 'coffee-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'shopify_app'
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
