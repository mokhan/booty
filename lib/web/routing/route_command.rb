require 'routing_module'
require 'web_request'

module Booty
  class RouteCommand
    include RoutingBehaviour

    def run(request)
      respond_to(WebRequest.new(request))
    end
  end
end
