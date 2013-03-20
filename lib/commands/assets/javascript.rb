module Booty
  module Assets
    class Javascript
      def matches(request)
        request["REQUEST_PATH"].include?(".js")
      end
      def run(resource)
        AssetResponse.new(200, resource, "text/javascript")
      end
    end
  end
end
