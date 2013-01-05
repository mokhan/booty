require "http_command_behaviour"

module Booty
  class FrontController
    def initialize(command_registry, view_engine)
      @command_registry = command_registry
      @view_engine = view_engine
    end
    def call(env)
      begin
        @command_registry.command_for(env).run_against(env)
      rescue => e
        html = @view_engine.render(:template => '501.html.erb', :model => e)
        [501, {"Content-Type" => "text/html"}, [html]]
      end
    end
  end
end
