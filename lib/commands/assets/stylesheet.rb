module Booty
  module Assets
    class Stylesheet
      def matches(request)
        request["REQUEST_PATH"].include?(".css")
      end
      def run_against(content)
        [200, {"Content-Type" => "text/css"}, [content]]
      end
    end
  end
end
