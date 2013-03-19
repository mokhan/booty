require 'route_command'

module Booty
  module Products
    class IndexCommand < Booty::RouteCommand
      handles :uri => /\/products$/, :verb => :GET

      def initialize(view_engine, products_repository)
        @view_engine = view_engine
        @repository = products_repository
      end
      def run(request)
        HtmlResponse.new(:template => "/products/index.html.erb", :model => OpenStruct.new(:items => @repository.find_all)).run(@view_engine)
      end
    end
  end
end
