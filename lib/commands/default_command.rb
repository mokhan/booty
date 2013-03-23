require 'erb'
require 'ostruct'

module Booty
  class DefaultCommand
    def initialize(view_engine)
      @view_engine = view_engine
    end
    def matches?(request)
      true
    end
    def run(request)
      HtmlResponse.new(:template => "/404.html.erb", :status => 404)
    end
  end
end
