require "spec_helper"

describe Booty::Sessions::NewOAuthCommand do
  let(:sut) { Booty::Sessions::NewOAuthCommand.new(view_engine) }
  let(:view_engine) { fake }

  context "when viewed" do
    let(:html) { "<html/>" }
    let(:request) { {} }
    let(:result) { sut.run(request) }

    before :each do
      ENV['GOOGLE_BOOTYCALL_CLIENT_ID'] = 'fish'
    end

    it "should redirect" do
      result.status.should == 301
    end

    it "should should redirect to google for signin" do
      result.location.should == 'https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=fish&redirect_uri=http%3A%2F%2Flocalhost%3A9292%2Fsessions%2Fcreate&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile&state=bootycall&access_type=offline&approval_prompt=force'
    end
  end
end
