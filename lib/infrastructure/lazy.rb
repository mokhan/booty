require 'ioc'

module Booty
  class Lazy 
    def initialize(key)
      @key = key
    end

    def method_missing(name, *args, &block)
      @target ||= IOC.resolve(@key)
      @target.send(name, args, &block)
    end

    def self.load(key)
      Lazy.new(key)
    end
  end
end
