require "spec_helper"

describe Booty::Products::NewCommand do
  let(:sut) { Booty::Products::NewCommand.new(view_engine) }
  let(:view_engine) { fake }

  context "when run" do
    let(:html) { DateTime.now.to_s }

    before :each do
      view_engine.stub(:render).with({:template => '/products/new.html.erb'}).and_return(html)
      @result = sut.run({})
    end
    it "should render the proper view" do
      @result.should == [200, {"Content-Type" => "text/html"}, [html]]
    end
  end
end
