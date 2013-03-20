require "spec_helper"

describe Booty::Sessions::NewCommand do
  let(:sut) { Booty::Sessions::NewCommand.new(view_engine) }
  let(:view_engine) { fake }

  context "when viewed" do
    let(:html) { "<html/>" }
    let(:request) { {} }
    let(:result) { sut.run(request) }

    it "should return the correct status" do
      result.status.should == 200
    end

    it "should render the correct template" do
      result.template.should == '/sessions/new.html.erb'
    end
  end
end
