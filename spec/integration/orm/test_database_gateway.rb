class TestDatabaseGateway
  def self.connection
    @connection ||= Sequel.postgres('booty_test', :user => 'booty', :password => 'password', :host => 'localhost')
  end
  def self.delete_all
    TestDatabaseGateway.connection.from(:products).delete
  end
end
