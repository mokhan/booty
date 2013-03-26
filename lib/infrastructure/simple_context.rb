class SimpleContext
  def initialize(store = {})
    @store = store
  end
  def add(key, value)
    key.add_to(@store, value)
  end
  def remove(key)
    key.remove_from(@store)
  end
  def contains?(key)
    key.contained_in?(@store)
  end
  def item_for(key)
    key.item_from(@store)
  end
end
