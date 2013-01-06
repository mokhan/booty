require 'http_command_behaviour'

module Booty
  module Dashboard
    class IndexCommand 
      include HttpCommandBehaviour

      def initialize(view_engine)
        @view_engine = view_engine
      end
      def matches(request)
        request["REQUEST_PATH"] == "/"
      end
      def run(request)
        html_response(@view_engine.render(:template => "/dashboard/index.html.erb"))
      end
    end
  end
end
