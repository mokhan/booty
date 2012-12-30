module Booty
  module Dashboard
    class IndexCommand 
      def initialize(view_engine)
        @view_engine = view_engine
      end
      def matches(request)
        request["REQUEST_PATH"] == "/"
      end
      def run_against(request)
        respond_with(:content => @view_engine.render(:template => "/dashboard/index.html.erb"))
      end
      private 
      def respond_with(options)
        defaults = { :status => 200, :content_type => "text/html" }
        options = options.merge(defaults)
        [options[:status], {"Content-Type" => options[:content_type]}, [options[:content]]]
      end
    end
  end
end
