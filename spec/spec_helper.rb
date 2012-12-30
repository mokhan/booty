require 'fakes-rspec'
Dir.glob("lib/**/*.rb").each { |x| $:.unshift(File.dirname(x)) }
Dir.glob("lib/**/*.rb").each { |x| require File.basename(x) }
