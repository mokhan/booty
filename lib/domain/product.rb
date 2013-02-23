
class DomainObject
  attr_reader :id
  DEFAULT_ID = -1
  def initialize(options = {})
    @id = options[:id] || DEFAULT_ID
  end
  def ==(other)
    return true if other.object_id == object_id
    return false if self.id == DEFAULT_ID || other.class != self.class
    id == other.id
  end
end

class Product < DomainObject
  attr_reader :name

  def initialize(attributes = {})
    super
    @name = attributes[:name]
  end
  def change_name(new_name)
    @name = new_name
  end
  def to_s
    "#{id} #{name}"
  end
end
