module Booty  
  class HtmlResponse
    def initialize(options)
      @options = options
    end

    def run
      [@options[:status], {"Content-Type" => @options[:content_type]}, [@options[:content]]]
    end
  end
end
