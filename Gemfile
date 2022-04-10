source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'rails', '~> 5.2.2'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.5'
gem 'discordrb'
gem 'graphql-client'
gem 'awesome_print'
gem 'dry-transaction'
gem 'devise'
gem 'activeadmin'
gem 'twitter'
gem 'bugsnag'
gem 'coffee-rails', '~> 5.0.0'


group :development do
  gem 'bullet'
  gem 'i18n-debug', require: false
  gem 'rubocop', '~> 0.57.2', require: false
  gem 'rubycritic', require: false
  gem 'listen'
  gem 'letter_opener_web', '~> 1.0'
end

group :development, :test, :fakeprod, :realprod do
  gem 'figaro'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'faker'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rails-footnotes', require: false
  gem 'rails_real_favicon', require: false
  gem 'seedbank'
  gem 'shog'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'json-schema'
  gem 'pundit-matchers'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'timecop', '~> 0.8'
  gem 'vcr'
  gem 'webmock'
end
