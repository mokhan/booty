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
        instance = interceptor.intercept(instance)
      end
      instance
    end

    def as_singleton
      @factory_method = memoize(@factory_method)
    end

    def intercept(method)
      interceptor = InterceptorRegistration.new(method)
      @interceptors.push(interceptor)
      interceptor
    end
  end

  class InterceptorRegistration
    def initialize(method_symbol)
      @method = method_symbol
    end

    def with(interceptor)
      @interceptor = interceptor
    end

    def intercept(instance)
      proxy= Proxy.new(instance)
      proxy.add(@method, @interceptor)
      proxy
    end
  end

  class Proxy
    def initialize(instance)
      @instance = instance
    end

    def add(method, interceptor)
      self.class.define_method(method.to_sym) do |*args|
        interceptor.intercept(create_invocation_for(method, args))
      end
    end

    def create_invocation_for(method, args)
      Invocation.new(@instance, method, args)
    end
  end

  class Invocation
    attr_reader :instance, :method, :arguments

    def initialize(instance, method, args)
      @instance = instance
      @method = method
      @arguments = args
    end

    def proceed
      instance.send(@method, @arguments) 
    end
  end
end
