module Booty
  module Assets
    class Javascript
      def matches(request)
        request["REQUEST_PATH"].include?(".js")
      end
      def run(content)
        [200, {"Content-Type" => "text/javascript"}, [content]]
      end
    end
  end
end
