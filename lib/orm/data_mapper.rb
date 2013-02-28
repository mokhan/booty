class DataMapper
  def initialize(clazz)
    @clazz = clazz
  end
  def map_from(row)
    @clazz.new(row)
  end
end
