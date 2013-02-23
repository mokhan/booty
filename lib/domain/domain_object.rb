require "identifiable"

class DomainObject
  include Identifiable

  def initialize(options = {})
    @id = options[:id] || DEFAULT_ID
    options.each do |key, value|
      instance_variable_set("@#{key}".to_sym, value)
    end
  end

  def to_s
    instance_variables.map do |variable| 
      "#{variable}: #{instance_variable_get(variable)} "
    end.join
  end
end
