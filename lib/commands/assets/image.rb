module Booty
  module Assets
    class Image
      def matches(request)
        request["REQUEST_PATH"].include?(".png")
      end
      def run(resource)
        AssetResponse.new(200, resource, "image/png")
      end
    end
  end
end
