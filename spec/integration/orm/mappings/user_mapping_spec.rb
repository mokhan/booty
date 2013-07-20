require "integration_helper"

describe User do
  context "when fetching all" do
    let(:user) { User.new(:id => 1, :username => "putty") }

    before :each do
      @configuration.add(UserMapping.new)
      @session = @session_factory.create_session
      @session.save(user)
    end

    let(:results) { @session.find_all(User)  }

    it "should return each" do
      results.count.should == 1
    end

    it "should return an instance" do
      results.first.should be_an_instance_of(User)
    end

    it "should map the name properly" do
      results.first.username.should == user.username
    end

    it "should map the id properly" do
      results.first.id.should == user.id
    end
  end
end
