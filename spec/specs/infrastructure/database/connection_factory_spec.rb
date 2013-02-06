require "spec_helper"

describe DatabaseConnectionFactory do
  let(:sut) { DatabaseConnectionFactory.new(database_configuration, connection_provider) }
  let(:database_configuration) { fake }
  let(:connection_provider) { fake }

  context "when creating a new connection" do
    let(:connection) { fake }
    before :each do
      connection_provider.stub(:provide).and_return(connection)
      database_configuration.stub(:configure).with(connection).and_return(connection)
      @result = sut.create_connection
    end
    it "should return a new connection using the proper connection configuration" do
      @result.should == connection
    end
    it "should configure the connection" do
      database_configuration.should have_received(:configure, connection)
    end
  end
end
