require 'routed_command'
require 'block_specification'

module Booty
  class RouteRegistry
    def initialize(routes = [])
      @routes = routes
    end

    def register(route)
      if block_given?
        register_route(route) { |request| yield(request) }
      else
        register_route(route) { |request| route.matches?(request) }
      end
    end

    def route_for(request)
      @routes.find { |route| route.matches?(request) }
    end

    private

    def register_route(command, &block)
      @routes.push(RoutedCommand.new(BlockSpecification.new(&block), command))
    end
  end
end
