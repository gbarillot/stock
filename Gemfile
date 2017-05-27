source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.0'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'haml-rails'
gem 'barby'
gem 'devise'
gem "font-awesome-rails"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13.0'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'minitest'
  gem 'minitest-focus'
  gem 'minitest-rails'
  gem 'minitest-rails-capybara'
  gem 'minitest-matchers'
  gem 'minitest-metadata'
  gem 'minitest-reporters', '~> 1.0'
  gem 'minitest-profiler'
  gem 'valid_attribute'
  gem 'warden'
  gem 'webmock'
  gem 'timecop'
  gem 'rack-test'
  gem 'json_expressions'
  gem 'vcr'
end
