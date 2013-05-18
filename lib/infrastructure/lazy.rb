require 'spank'

module Booty
  class Lazy 
    def initialize(resolver = ->() { })
      @resolver = resolver
    end

    def method_missing(name, *args, &block)
      @target ||= @resolver.call
      @target.send(name, args, &block)
    end

    def self.load(key, resolver = ->() { Spank::IOC.resolve(key) })
      Lazy.new(resolver)
    end
  end
end
