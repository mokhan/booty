require "spec_helper"
require 'sequel'
require 'pg'

describe DatabaseGateway do
  let(:connection_factory) { fake }
  let(:sut) { DatabaseGateway.new(connection_factory) }

  context "when executing a query against the database" do
    let(:connection) { Sequel.postgres('booty', :user => 'booty', :password => 'password', :host => 'localhost') }

    before(:each) do
      connection.create_table :users do
        primary_key :id
        String :name
      end
      connection.from(:users).insert(:name => 'mo')
      connection_factory.stub(:create_connection).and_return(connection)
    end
    after(:each) do
      connection.drop_table :users
    end
    it "should be able to return a result set" do
      query = Query.new { |c| c.from(:users).all }
      results = sut.run(query)
      results.should == [:id => 1, :name => 'mo']
    end
  end
end
