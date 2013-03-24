require "log"

module Booty
  class FrontController
    def initialize(command_registry, view_engine)
      @command_registry = command_registry
      @view_engine = view_engine
    end
    def call(env)
      begin
        route = @command_registry.route_for(env)
        result = route.run(env)
        result.run(@view_engine)
      rescue => e
        logger.error(e)
        [501, {"Content-Type" => "text/html"}, [@view_engine.render(:template => '501.html.erb', :model => e)]]
      end
    end
  end
end
