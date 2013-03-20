module Booty
  module Assets
    class Stylesheet
      def matches(request)
        request["REQUEST_PATH"].include?(".css")
      end
      def run(resource)
        AssetResponse.new(200, resource, "text/css")
      end
    end
  end
end
