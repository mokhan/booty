module Booty
  module Registrations
    class CreateCommand < RouteCommand
      handles :uri => /^\/registrations\/create$/, :method => :POST

      def initialize(users_repository)
        @users = users_repository
      end

      def respond_to(request)
        user = User.new(:username => request.payload[:username])
        user.change_password(request.payload[:password])
        @users.save(user)
        RedirectResponse.new
      end
    end
  end
end
