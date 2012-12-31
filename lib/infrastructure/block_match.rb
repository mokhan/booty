require 'boolean_matching_behaviour'

module Booty
  class BlockMatch
    include BooleanMatchingBehaviour
    def initialize(&block)
      @block = block
    end
    def matches(item)
      @block.call(item)
    end
  end
end
