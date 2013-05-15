module Booty
  module Registrations
    class CreateCommand < RouteCommand
      handles :uri => /^\/registrations\/create$/, :method => :POST

      def initialize(users_repository)
        @users = users_repository
      end

      def respond_to(request)
        @users.save(map_from(request.payload))
        RedirectResponse.new
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
