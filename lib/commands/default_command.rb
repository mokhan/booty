require 'erb'
require 'ostruct'
require 'expose_binding_behaviour'

module Booty
  class DefaultCommand
    def initialize(view_engine)
      @view_engine = view_engine
    end
    def matches(request)
      true
    end
    def run_against(request)
      [404, {"Content-Type" => "text/html"}, [@view_engine.render(:template => "/404.html.erb")]]
    end
  end
end
