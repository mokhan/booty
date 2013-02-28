class Hash
  def map_using(mapper)
    mapper.map_from(self)
  end
end
