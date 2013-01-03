module Booty
  module Assets
    class AssetCommand
      def matches(request)
        path = request["REQUEST_PATH"]
        path.include?(".js") || path.include?(".css") || path.include?(".png")
        #/(js|css|png)^/.match(path)
      end
      def run_against(request)
        path = request["REQUEST_PATH"]
        content = File.read(File.join(Dir.pwd, path))
        if path.include?(".js")
          return [200, {"Content-Type" => "text/javascript"}, [content]]
        end
        if path.include?(".css")
          return [200, {"Content-Type" => "text/css"}, [content]]
        end
        if path.include?(".png")
          return [200, {"Content-Type" => "image/png"}, [content]]
        end
      end
    end
  end
end
