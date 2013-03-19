require 'product'

module Booty
  module Products
    class CreateCommand < Booty::RouteCommand
      handles :uri => /\/products$/, :method => :POST

      def initialize(products_repository)
        @repository = products_repository
      end

      def respond_to(request)
        @repository.save(map_from(request.payload))
        RedirectResponse.new(:location => '/products').run
      end

      private 
      def map_from(payload)
        Product.new(payload[:product])
      end
    end
  end
end
