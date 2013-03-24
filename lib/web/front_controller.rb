module Booty
  class FrontController
    def initialize(command_registry, view_engine)
      @command_registry = command_registry
      @view_engine = view_engine
    end
    def call(env)
      begin
        route = @command_registry.route_for(env)
        p "ROUTE #{route}"
        result = route.run(env)
        p "RESULT #{result}"
        result.run(@view_engine)
      rescue => e
        p e
        [501, {"Content-Type" => "text/html"}, [@view_engine.render(:template => '501.html.erb', :model => e)]]
      end
    end
  end
end
