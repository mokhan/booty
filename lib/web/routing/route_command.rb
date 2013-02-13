require 'http_command_behaviour'
require 'routing_module'

module Booty
  class RouteCommand
    include HttpCommandBehaviour
    include RoutingBehaviour
  end
end
