require "route_command"
require "ostruct"

module Booty
  module Dashboard
    class IndexCommand < Booty::RouteCommand
      handles :uri => /^\/$/, :verb => :GET

      def initialize(view_engine, users_repository)
        @view_engine = view_engine
        @users = users_repository
      end

      def respond_to(request)
        HtmlResponse.new(:template => "/dashboard/index", :model => lookup_user_from(request))
      end

      private

      def lookup_user_from(request)
        if request.cookies.has_key?(Cookies::SESSION)
          @users.find_by(request.cookies[Cookies::SESSION])
        else
          OpenStruct.new(:username => 'world')
        end
      end
    end
  end
end
