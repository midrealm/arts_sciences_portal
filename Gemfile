source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

gem 'rails', '~> 7.1.1'
gem 'puma', '~> 6.4'
gem 'webpacker', '~> 4.0'
gem 'psych', '< 4' #update this at some point
gem 'sass-rails', '~> 5'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

gem 'pg'
gem 'devise'
gem 'pundit'
gem 'rest-client'
gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'

gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 4.0.0.beta2' #TODO: update this when rspec merges
  gem 'rspec-junklet'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
