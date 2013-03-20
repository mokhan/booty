module Booty
  class FrontController
    def initialize(command_registry, view_engine)
      @command_registry = command_registry
      @view_engine = view_engine
    end
    def call(env)
      begin
        @command_registry.command_for(env).run(env).run(@view_engine)
      rescue => e
        p e
        [501, {"Content-Type" => "text/html"}, [@view_engine.render(:template => '501.html.erb', :model => OpenStruct.new(:error => e))]]
      end
    end
  end
end
