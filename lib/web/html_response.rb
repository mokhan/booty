module Booty
  class HtmlResponse
    attr_reader :template, :model, :status

    def initialize(template: '', model: nil, status: 200)
      @template = template
      @model = model
      @status = status
    end

    def run(view_engine)
      html = render_html_using(view_engine)
      [@status, {"Content-Type" => "text/html"}, [html]]
    end

    private

    def render_html_using(view_engine)
      return view_engine.render(:template => @template, :model => @model) if @model
      view_engine.render(:template => @template)
    end
  end
end
