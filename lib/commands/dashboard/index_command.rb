module Booty
  module Dashboard
    class IndexCommand 
      def initialize

      end
      def matches(request)
        request["REQUEST_PATH"] == "/"
      end
      def run_against(request)
      end
    end
  end
end
