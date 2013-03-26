class Key
  def initialize(key)
    @key = key
  end
  def add_to(store, value)
    store[to_sym] = value
  end
  def remove_from(store)
    store[to_sym] = nil
  end
  def contained_in?(store)
    item_from(store)
  end
  def item_from(store)
    store[to_sym]
  end
  def to_sym
    @key.to_sym
  end
end
