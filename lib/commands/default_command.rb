require 'erb'
require 'ostruct'

module Booty
  class DefaultCommand
    def initialize(view_engine)
      @view_engine = view_engine
    end
    def matches(request)
      true
    end
    def run(request)
      [404, {"Content-Type" => "text/html"}, [@view_engine.render(:template => "/404.html.erb")]]
    end
  end
end
