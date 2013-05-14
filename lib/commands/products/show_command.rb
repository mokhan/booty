module Booty
  module Products
    class ShowCommand < RouteCommand
      handles :uri => /^\/products\/(\d+)+$/, :method => :GET

      def initialize(view_engine, products_repository)
        @view_engine = view_engine
        @repository  = products_repository
      end

      def respond_to(request)
        id = request.path.match(/.*\/(\d+)+$/)[1].to_i
        product = @repository.find_by(id)
        HtmlResponse.new(:template => "/products/show", :model => product)
      end
    end
  end
end
