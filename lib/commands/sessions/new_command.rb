module Booty
  module Sessions
    class NewCommand < RouteCommand
      handles :uri => /^\/sessions\/new$/, :method => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end
      def run(request)
        html = @view_engine.render(:template => '/sessions/new.html.erb')
        HtmlResponse.new(:content => html).run
      end
    end
  end
end
