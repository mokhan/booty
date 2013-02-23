module Identifiable
  attr_reader :id
  DEFAULT_ID = -1

  def ==(other)
    return true if other.object_id == object_id
    return false if self.id == DEFAULT_ID || other.class != self.class
    id == other.id
  end
end

class DomainObject
  include Identifiable

  def initialize(options = {})
    @id = options[:id] || DEFAULT_ID
    options.each do |key, value|
      instance_variable_set("@#{key}".to_sym, value)
    end
  end
end

class Product < DomainObject
  attr_reader :name

  def change_name(new_name)
    @name = new_name
  end

  def to_s
    "#{id} #{name}"
  end
end
