require "spec_helper"
require 'sequel'
require 'pg'

describe DatabaseGateway do
  let(:connection_factory) { fake }
  let(:sut) { DatabaseGateway.new(connection_factory) }

  context "when executing a query against the database" do
    let(:connection) { Sequel.postgres('booty', :user => 'booty', :password => 'password', :host => 'localhost') }

    before(:each) do
      connection_factory.stub(:create_connection).and_return(connection)
    end
    it "should be able to return a result set" do
      query = Query.new { |c| c.from(:users).all }
      results = sut.run(query)
      results.should == [:id => 1]
    end
  end
end
