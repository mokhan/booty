require 'http_command_behaviour'
require 'routing_module'
require 'web_request'

module Booty
  class RouteCommand
    include HttpCommandBehaviour
    include RoutingBehaviour

    def run(request)
      respond_to(WebRequest.new(request))
    end
  end
end
