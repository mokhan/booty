class DatabaseConfiguration
  def configure(connection)
    connection.postgres('booty', :user => 'booty', :password => 'password', :host => 'localhost')
  end
end
