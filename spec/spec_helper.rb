if ENV['CI']
  require 'simplecov'
  SimpleCov.start
end
Bundler.require(:default, :test)
require_relative 'integration/orm/test_database_gateway'
require 'booty'
