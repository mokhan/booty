require 'component'

module Booty
  class Container
    def initialize
      @items = {}
      register(:container) { self }
    end
    def register(key, &block)
      component = Component.new(&block)
      coponents_for(key).push(component)
      component
    end
    def resolve(key)
      instantiate(coponents_for(key).first)
    end
    def resolve_all(key)
      coponents_for(key).map {|item| instantiate(item) }
    end
    def build(type)
      constructor = type.instance_method('initialize')
      parameters = constructor.parameters.map {|req, parameter| resolve(parameter.to_sym)}
      type.send(:new, *parameters)
    end

    private

    def coponents_for(key)
      @items[key] = [] unless @items[key]
      @items[key]
    end
    def instantiate(component)
      component.create(self)
    end
  end
end
