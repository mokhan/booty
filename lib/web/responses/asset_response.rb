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
        "Expires" => CGI.rfc1123_date(Time.now + (365 * 24 * 60 * 60))
      }
      [@status, headers, [File.read(File.join(Dir.pwd, @file_path))]]
    end
  end
end
