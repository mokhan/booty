source "https://rubygems.org"
ruby '2.0.0'
gem 'rake'
gem 'rack'
gem 'sequel'
gem 'pg'
gem 'oauth2'
gem 'bcrypt-ruby'
gem 'spank'
gem 'humble'

group :development do
  gem 'mongrel', '>= 1.1.5.pre'
end

group :test do
  gem 'rspec', '~> 2.13.0'
  gem 'fakes-rspec'
  gem 'watir-webdriver'
  gem 'headless'
  gem 'simplecov', :require => false
  gem 'mongrel', '>= 1.1.5.pre'
end

group :production do
  gem 'unicorn'
  gem 'mongrel', '>= 1.1.5.pre'
end
