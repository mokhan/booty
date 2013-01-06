module Booty
  module Assets
    class Image
      def matches(request)
        request["REQUEST_PATH"].include?(".png")
      end
      def run(content)
        [200, {"Content-Type" => "image/png"}, [content]]
      end
    end
  end
end
