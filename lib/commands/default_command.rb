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
      HtmlResponse.new(:template => "/404", :status => 404)
    end
    def command
      self
    end
  end
end
