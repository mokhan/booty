require "spec_helper"

module Booty::Assets
  describe AssetCommand do
    let(:sut){ AssetCommand.new }

    context "when a request is for a javascript asset" do
      it "should match the route" do
        sut.matches( { "REQUEST_PATH"=>"/assets/js/bootstrap.js" } ).should be_true
      end
    end
    context "when a request is for a css asset" do
      it "should match the route" do
        sut.matches( { "REQUEST_PATH"=>"/assets/css/bootstrap.css" } ).should be_true
      end
    end
    context "when a request is for an image asset" do
      it "should match the route" do
        sut.matches( { "REQUEST_PATH"=>"/assets/img/bootstrap.png" } ).should be_true
      end
    end
    context "when a request is for anything else" do
      it "should not match the route" do
        sut.matches( { "REQUEST_PATH"=>"/blah/blah" } ).should be_false
      end
    end
    context "when serving a static asset" do
      before :each do
        @result = sut.run_against( { "REQUEST_PATH" => "/assets/js/bootstrap.js" } )
      end
      it "should serve the static resource" do
        @result.should == [200, {"Content-Type" => "text/html"}, [File.read('assets/js/bootstrap.js')]]
      end
    end
  end
end
