module RoutingModule
  def self.included base
    base.extend ClassMethods
  end
  module ClassMethods
    def handles(routing)
      define_method(:matches) do |request|
        specification = RouteRequestSpecification.new
        specification.handles(routing)
        specification.matches(request)
      end
    end
  end
end
