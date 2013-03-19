module Booty
  class HtmlResponse
    def initialize(options)
      @template = options[:template]
      @model = options[:model]
    end

    def run(view_engine = nil)
      html = render_html_using(view_engine)
      [200, {"Content-Type" => "text/html"}, [html]]
    end

    private

    def render_html_using(view_engine)
      if @model
        view_engine.render(:template => @template, :model => @model)
      else
        view_engine.render(:template => @template)
      end
    end
  end
end
