require "block_match"

module Booty
  module Specification
    def or(other_predicate = nil, &block)
      matcher = create_predicate(other_predicate, &block)
      create_predicate { |item| self.matches(item) || matcher.matches(item) }
    end

    def and(other_predicate = nil, &block)
      matcher = create_predicate(other_predicate, &block)
      create_predicate { |item| self.matches(item) && matcher.matches(item) }
    end

    private

    def create_predicate(predicate = nil, &block)
      block_given? ? BlockMatch.new(&block) : predicate
    end
  end
end
