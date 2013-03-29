module Booty
  class AssetResponse
    attr_reader :status, :file_path, :content_type

    def initialize(status = 200, file_path, content_type)
      @status = status
      @file_path = file_path
      @content_type = content_type
    end

    def run(view_engine)
      [@status, {"Content-Type" => @content_type}, [File.read(File.join(Dir.pwd, @file_path))]]
    end
  end
end
