module Booty
  module Sessions
    class NewCommand < RouteCommand
      handles :uri => /^\/sessions\/new$/, :method => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end
      def run(request)
        render_html(@view_engine.render(:template => '/sessions/new.html.erb'))
      end
    end
  end
end
