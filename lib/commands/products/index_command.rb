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
        html_response(@view_engine.render(:template => "/products/index.html.erb", :model => OpenStruct.new(:items => @repository.find_all)))
      end
    end
  end
end
