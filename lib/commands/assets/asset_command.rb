module Booty::Assets
  class AssetCommand
    def matches(request)
      path = request["REQUEST_PATH"]
      path.include?(".js") || path.include?(".css") || path.include?(".png")
      #/(js|css|png)^/.match(path)
    end
  end
end
