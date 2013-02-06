require "spec_helper"

describe DatabaseConfiguration do
  let(:sut) { DatabaseConfiguration.new }
  context "when configuring a new connection" do
    let(:connection) { fake }
    before :each do
      sut.configure(connection)
    end
    it "should supply the proper settings" do
      connection.should have_received(:postgres, 'booty', :user => 'booty', :password => 'password', :host => 'localhost')
    end
  end
end
