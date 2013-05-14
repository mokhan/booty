require "spec_helper"

describe DatabaseGateway do
  let(:connection_factory) { DatabaseConnectionFactory.new(DatabaseConfiguration.new, SequelConnectionProvider.new) }
  let(:sut) { DatabaseGateway.new(context, key) }
  let(:context) { SimpleContext.new }
  let(:key) { Key.new('blah') }
  let(:session) { Session.new(connection) }
  let(:connection) { connection_factory.create_connection }

  before :each do
    TestDatabaseGateway.connection.create_table :blah do
      primary_key :id
      String :name
    end
    context.add(key, session)
  end
  after(:each) do
    TestDatabaseGateway.connection.drop_table :blah
  end

  context "when executing a query against the database" do
    before(:each) do
      TestDatabaseGateway.connection.from(:blah).insert(:name => 'mo')
    end
    it "should be able to return a result set" do
      query = DatabaseQuery.new { |c| c.from(:blah).all }
      results = sut.run(query)
      results.should == [:id => 1, :name => 'mo']
    end
  end
  context "when executing a command against the database" do
    it "should run the command against the open connection" do
      command = DatabaseCommand.new { |c| c.from(:blah).insert(:name => 'mo') }
      sut.run(command)
      TestDatabaseGateway.connection.from(:blah).count.should == 1
    end
  end
end
