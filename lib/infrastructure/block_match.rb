require 'specification'

module Booty
  class BlockMatch
    include Specification

    def initialize(&block)
      @block = block
    end

    def matches(item)
      @block.call(item)
    end
  end
end
