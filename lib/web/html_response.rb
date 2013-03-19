module Booty
  class HtmlResponse
    def initialize(options)
      @html = options[:content]
    end

    def run
      [200, {"Content-Type" => "text/html"}, [@html]]
    end
  end
end
