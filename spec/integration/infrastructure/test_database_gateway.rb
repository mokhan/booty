class TestDatabaseGateway
  def self.connection
    @connection ||= Sequel.postgres('booty_test', :user => 'booty', :password => 'password', :host => 'localhost')
  end
end
