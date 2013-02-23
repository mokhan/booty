require "identifiable"
require "property_bag"

class DomainObject
  include Identifiable
  include PropertyBag

  def initialize(attributes = {})
    @id = attributes[:id] || DEFAULT_ID
    attributes.each do |key, value|
      instance_variable_set("@#{key}".to_sym, value)
    end
  end

  def to_s
    instance_variables.map do |variable|
      ", #{variable}: #{instance_variable_get(variable)}"
    end.unshift(self.class.to_s).join
  end
end
