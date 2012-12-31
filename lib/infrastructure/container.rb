module Booty
  class Component
    def initialize(&block)
      @factory_method = block
    end
    def call(*args)
      @factory_method.call(args)
    end
    def as_singleton
      @factory_method = memoize(@factory_method)
    end

    private

    def memoize(factory_method)
      lambda { |*args| @cache ||= factory_method.call(args) }
    end
  end
  class Container
    def initialize
      @items = {}
      register(:container) { self }
    end
    def register(key, &block)
      component = Component.new(&block)
      items_for(key).push(component)
      component
    end
    def resolve(key)
      instantiate(items_for(key).first)
    end
    def resolve_all(key)
      items_for(key).map {|item| instantiate(item) }
    end

    def to_s
      object_id.to_s
    end

    private

    def items_for(key)
      @items[key] = [] unless @items[key]
      @items[key]
    end
    def instantiate(factory_method)
      factory_method.call(self)
    end
  end
end
