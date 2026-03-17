source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.2'

gem 'rails'
gem 'puma'
gem 'psych'
gem 'turbolinks'
gem 'jbuilder'
gem 'sassc-rails'
gem 'jsbundling-rails'

gem 'pg'
gem 'devise'
gem 'pundit'
gem 'rest-client'
gem 'bootstrap'
gem 'jquery-rails'

gem 'bootsnap', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rspec-junklet'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
