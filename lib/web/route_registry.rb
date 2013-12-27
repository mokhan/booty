require 'routed_command'

module Booty
  class RouteRegistry
    def initialize(routes = [])
      @routes = routes
    end

    def register(route)
      @routes.push(route)
    end

    def route_for(request)
      @routes.find { |route| route.matches?(request) }
    end
  end
end
