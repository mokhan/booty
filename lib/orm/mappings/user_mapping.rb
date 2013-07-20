require 'user'

class UserMapping < Humble::DatabaseMapping
  def run(map)
    map.table :users
    map.type User
    map.primary_key(:id, :default => -1)
    map.column :username
    #map.column :password
  end
end
