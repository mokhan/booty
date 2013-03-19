require "html_response"

module Booty
  module HttpCommandBehaviour
    def respond_with(options = {})
      defaults = { :status => 200, :content_type => "text/html" }
      options = options.merge(defaults)

      response = HtmlResponse.new(options)
      response.run
    end
    def render_html(html)
      respond_with(:content_type => "text/html", :content => html)
    end
  end
end
