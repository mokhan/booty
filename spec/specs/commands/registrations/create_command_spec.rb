require "spec_helper"

module Booty
  module Registrations
    describe CreateCommand do
      let(:sut) { Booty::Registrations::CreateCommand.new(repository) }
      let(:repository) { fake }

      describe "when run with a usable username and password" do
        let(:request) { fake }
        let(:user) { fake }

        before :each do
          User.stub(:new).with(:username => 'mo').and_return(user)
          request.stub(:payload).and_return({:username => 'mo', :password => 'password'})
        end

        let!(:result) { sut.respond_to(request) }

        it "should redirect to the dashboard" do
          result.status.should == 301
          result.location.should == '/'
        end

        it "should save a new user" do
          repository.should have_received(:save, user)
        end

        it "should update the users password" do
          user.should have_received(:change_password, 'password')
        end

        it "should issue a cookie to the browser" do
          p result
        end
      end
    end
  end
end
