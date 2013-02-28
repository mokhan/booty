class Array
  def map_all_using(mapper)
    map { |item| mapper.map_from(item) }
  end
end
