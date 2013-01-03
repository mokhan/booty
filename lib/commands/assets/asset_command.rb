module Booty
  module Assets
    class AssetCommand
      def matches(request)
        path = request["REQUEST_PATH"]
        path.include?(".js") || path.include?(".css") || path.include?(".png")
        #/(js|css|png)^/.match(path)
      end
      def run_against(request)
        content = File.read(File.join(Dir.pwd, request["REQUEST_PATH"]))
        [200, {"Content-Type" => "text/html"}, [content]]
      end
    end
  end
end
