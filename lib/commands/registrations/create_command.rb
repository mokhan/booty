require 'route_command'

module Booty
  module Registrations
    class CreateCommand < Booty::RouteCommand
      handles :uri => /^\/registrations\/$/, :method => :POST

      def initialize(users_repository)
        @users = users_repository
      end

      def respond_to(request)
        user = map_from(request.payload)
        @users.save(user)
        RedirectResponse.new.add(Cookie.new(Cookies::SESSION, user.id))
      end

      private

      def map_from(payload)
        user = User.new(:username => payload[:username])
        user.change_password(payload[:password])
        user
      end
    end
  end
end
