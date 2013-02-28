
module Booty
  module Products
    class ShowCommand < RouteCommand
      handles :uri => /^\/products\/(\d+)+$/, :method => :GET

      def initialize(view_engine, products_repository)
        @view_engine = view_engine
        @repository  = products_repository
      end

      def run(request)
        product = @repository.find_by(2)
        html = @view_engine.render({:template => '/products/show.html.erb', :model => OpenStruct.new(:product => product)})
        [200, {"Content-Type" => 'text/html'}, [html]]
      end
    end
  end
end
