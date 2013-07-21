class IdentityMap
  def initialize(items = {})
    @items = items
  end

  def add(item)
    @items[item.id] = item
  end

  def has_item_for?(id)
    @items.has_key?(id)
  end

  def item_for(id)
    @items[id]
  end

  def evict(item)
    @items.reject! { |key, value| key == item.id }
  end
end
