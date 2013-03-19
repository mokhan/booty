require 'route_command'

module Booty
  module Products
    class NewCommand < Booty::RouteCommand
      handles :uri => /^\/products\/new$/, :method => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end

      def run(request)
        HtmlResponse.new(:template => "/products/new.html.erb").run(@view_engine)
      end
    end
  end
end
