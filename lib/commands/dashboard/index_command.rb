require 'http_command_behaviour'
require 'routing_module'

module Booty
  module Dashboard
    class IndexCommand 
      include HttpCommandBehaviour
      include RoutingModule

      handles :uri => /\/$/, :verb => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end
      def run(request)
        html_response(@view_engine.render(:template => "/dashboard/index.html.erb"))
      end
    end
  end
end
