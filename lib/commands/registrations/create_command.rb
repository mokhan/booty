module Booty
  module Registrations
    class CreateCommand < RouteCommand
      handles :uri => /^\/registrations\/create$/, :method => :POST

      def initialize
        
      end
      def run(request)
        
      end
    end
  end
end
