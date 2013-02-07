require 'http_command_behaviour'

module Booty
  module Products
    class IndexCommand
      include HttpCommandBehaviour

      def initialize(view_engine, products_repository)
        @view_engine = view_engine
        @repository = products_repository
      end
      def matches(request)
        request["REQUEST_PATH"] == "/products"
      end
      def run(request)
        html_response(@view_engine.render(:template => "/products/index.html.erb", :model => OpenStruct.new(:items => @repository.find_all)))
      end
    end
  end
end
