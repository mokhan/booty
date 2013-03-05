require "spec_helper"

describe Booty::Sessions::NewCommand do
  let(:sut) { Booty::Sessions::NewCommand.new(view_engine) }
  let(:view_engine) { fake }

  context "when viewed" do
    let(:html) { "<html/>" }
    let(:request) { {} }
    before :each do
      view_engine.stub(:render).with({:template => '/sessions/new.html.erb'}).and_return(html)
    end
    let(:result) { sut.run(request) }

    it "should render the correct view" do
      result.should == [200, "Content-Type" => "text/html" [ html ]]
    end
  end
end
