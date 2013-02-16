class Product
  attr_accessor :id, :name
  def initialize(attributes)
    @id = attributes[:id] || -1
    @name = attributes[:name]
  end
  def to_s
    "#{id} #{name}"
  end
  def attributes
    {:id => id, :name => name}
  end
end
