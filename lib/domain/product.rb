class Product
  attr_reader :id, :name

  def initialize(attributes)
    @id = attributes[:id] || -1
    @name = attributes[:name]
  end
  def to_s
    "#{id} #{name}"
  end
end
