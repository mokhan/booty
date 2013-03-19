require "route_command"

module Booty
  module Dashboard
    class IndexCommand < Booty::RouteCommand
      handles :uri => /^\/$/, :verb => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end

      def run(request)
        HtmlResponse.new(:template => "/dashboard/index.html.erb").run(@view_engine)
      end
    end
  end
end
