require 'specification'

module Booty
  class BlockSpecification
    include Booty::Specification

    def initialize(&block)
      @block = block
    end

    def matches?(item)
      @block.call(item)
    end
  end
end
