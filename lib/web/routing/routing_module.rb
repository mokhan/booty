require "request_specification"

module RoutingBehaviour
  def self.included base
    base.extend ClassMethods
  end
  module ClassMethods
    def handles(routing)
      define_method(:matches) do |request|
        RequestSpecification.new(routing).matches(request)
      end
    end
  end
end
