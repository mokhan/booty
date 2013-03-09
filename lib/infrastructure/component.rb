require 'lambda_behaviours'

module Booty
  class Component
    include LambdaBehaviours

    def initialize(class_key, &block)
      @factory_method = block
      @interceptors = []
    end

    def create(container)
      instance = @factory_method.call(container)
      @interceptors.each do |interceptor|
        interceptor.intercept(instance)
      end
      instance
    end

    def as_singleton
      @factory_method = memoize(@factory_method)
    end

    def intercept(method)
      interceptor = Interceptor.new(method)
      @interceptors.push(interceptor)
      interceptor
    end
  end
  class Interceptor
    def initialize(method_symbol)
      @method = method_symbol
    end
    def with(interceptor)
      @interceptor = interceptor
    end
    def intercept(instance)
      v = @interceptor
      instance.class.send(:define_method, @method.to_sym) do |input|
        p "WHAT THA"
        v.intercept(lambda do |*args| 
          p "invoke the original"
          #instance.send(@method, args) 
        end)
      end
      #instance.define_method(@method) do |*args|
        #@interceptor.intercept(lambda { |*args| instance.send(@method, args) })
      #end
    end
  end
end
