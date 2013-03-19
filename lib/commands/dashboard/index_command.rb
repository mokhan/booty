require "route_command"

module Booty
  module Dashboard
    class IndexCommand < Booty::RouteCommand
      handles :uri => /^\/$/, :verb => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end

      def run(request)
        html= @view_engine.render(:template => "/dashboard/index.html.erb")
        HtmlResponse.new(:content => html).run
      end
    end
  end
end
