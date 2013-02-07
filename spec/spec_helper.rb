require 'fakes-rspec'
require_relative 'integration/infrastructure/test_database_gateway'
Dir.glob("lib/**/*.rb").each { |x| $:.unshift(File.dirname(x)) }
Dir.glob("lib/**/*.rb").each { |x| require File.basename(x) }
