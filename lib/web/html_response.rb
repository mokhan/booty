module Booty
  class HtmlResponse
    def initialize(options)
      @html = options[:content]
      @template = options[:template]
    end

    def run(view_engine = nil)
      html= @html || view_engine.render(:template => @template)
      [200, {"Content-Type" => "text/html"}, [html]]
    end
  end
end
