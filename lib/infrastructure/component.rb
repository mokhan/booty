require 'lambda_behaviours'

module Booty
  class Component
    include LambdaBehaviours

    def initialize(&block)
      @factory_method = block
    end

    def create(container)
      @factory_method.call(container)
    end

    def as_singleton
      @factory_method = memoize(@factory_method)
    end
  end
end
