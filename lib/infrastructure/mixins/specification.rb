require "block_match"

module Booty
  module Specification
    def or(other_specification=nil, &block)
      if block_given?
        other_specification = BlockMatch.new(&block)
      end

      BlockMatch.new do |item|
        self.matches(item) || other_specification.matches(item)
      end
    end
  end
end
