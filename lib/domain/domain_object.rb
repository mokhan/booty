require "identifiable"

class DomainObject
  include Identifiable

  def initialize(attributes = {})
    @id = attributes[:id] || DEFAULT_ID
    attributes.each do |key, value|
      instance_variable_set("@#{key}".to_sym, value)
    end
  end

  def to_s
    instance_variables.map do |variable|
      "#{variable}: #{instance_variable_get(variable)} "
    end.join
  end

  def attributes
    items = instance_variables.map do |variable|
      [variable.to_s.gsub(/@/, '').to_sym, instance_variable_get(variable)]
    end
    Hash[items]
  end
end
