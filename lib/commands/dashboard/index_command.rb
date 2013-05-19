require "route_command"
require "ostruct"

module Booty
  module Dashboard
    class IndexCommand < Booty::RouteCommand
      handles :uri => /^\/$/, :verb => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end

      def respond_to(request)
        p request.cookies
        HtmlResponse.new(:template => "/dashboard/index")
      end
    end
  end
end
