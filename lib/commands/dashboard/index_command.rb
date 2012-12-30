module Booty
  module Dashboard
    class IndexCommand 
      def initialize(view_engine)
        @view_engine = view_engine
      end
      def matches(request)
        request["REQUEST_PATH"] == "/"
      end
      def run_against(request)
        [200, {"Content-Type" => "text/html"}, [@view_engine.render("/dashboard/index.html.erb")]]
      end
    end
  end
end
