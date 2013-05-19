module Booty
  class AssetResponse
    attr_reader :status, :file_path, :content_type

    def initialize(status = 200, file_path, content_type)
      @status = status
      @file_path = file_path
      @content_type = content_type
    end

    def run(view_engine)
      headers = {
        "Content-Type" => @content_type,
        "Cache-control" => "public, max-age=31536000",
        "Expires" => "Wed, 01 Jan 2014 22:00:00 GMT"
      }
      [@status, headers, [File.read(File.join(Dir.pwd, @file_path))]]
    end
  end
end
