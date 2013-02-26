require 'route_command'

module Booty
  module Products
    class NewCommand < Booty::RouteCommand
      handles :uri => /^\/products\/new$/, :method => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end

      def run(request)
        render_html(@view_engine.render(:template => '/products/new.html.erb'))
      end
    end
  end
end
