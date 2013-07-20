require 'product'

class ProductMapping < Humble::DatabaseMapping
  def run(map)
    map.table :products
    map.type Product
    map.primary_key(:id, :default => -1)
    map.column :name
  end
end
