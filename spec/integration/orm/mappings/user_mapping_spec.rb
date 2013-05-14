require "spec_helper"

describe User do
  let(:sut) { Repository.new(:users, gateway, DataMapper.new(User)) }
  let(:gateway) { DatabaseGateway.new(context, key) }
  let(:context) { SimpleContext.new }
  let(:key) { Key.new('blah') }
  let(:session) { Session.new(connection) }
  let(:connection) { DatabaseConnectionFactory.new(DatabaseConfiguration.new, SequelConnectionProvider.new).create_connection }

  before :each do
    context.add(key, session)
  end

  after :each do
    TestDatabaseGateway.delete_all
  end

  context "when fetching all" do
    let(:user) { User.new(:id => 1, :username => "putty") }

    before { TestDatabaseGateway.connection.from(:users).insert(:username => user.username) }

    let(:results) { sut.find_all  }

    it "should return each" do
      results.count.should == 1
    end

    xit "should return an instance" do
      results.first.should be_an_instance_of(User)
    end

    xit "should map the name properly" do
      results.first.username.should == user.username
    end

    xit "should map the id properly" do
      results.first.id.should_not be_nil
    end
  end
end
