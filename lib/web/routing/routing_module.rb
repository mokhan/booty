require "request_specification"

module RoutingBehaviour
  def self.included base
    base.extend ClassMethods
  end
  module ClassMethods
    def handles(routing)
      @route_specification = RequestSpecification.new(routing)
      define_method(:matches?) do |request|
        self.class.matches?(request)
      end
    end
    def matches?(request)
      @route_specification.matches?(request)
    end
  end
end
