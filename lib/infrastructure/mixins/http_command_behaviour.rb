module Booty
  module HttpCommandBehaviour
    def respond_with(options = {})
      defaults = { :status => 200, :content_type => "text/html" }
      options = options.merge(defaults)
      [options[:status], {"Content-Type" => options[:content_type]}, [options[:content]]]
    end
    def render_html(html)
      respond_with(:content_type => "text/html", :content => html)
    end
  end
end
