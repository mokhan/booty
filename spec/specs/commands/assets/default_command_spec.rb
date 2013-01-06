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
      it "should serve javascript resources" do
        result = sut.run( { "REQUEST_PATH" => "/assets/js/bootstrap.js" } )
        result.should == [200, {"Content-Type" => "text/javascript"}, [File.read('assets/js/bootstrap.js')]]
      end
      it "should serve css resources" do
        result = sut.run( { "REQUEST_PATH" => "/assets/css/bootstrap.css" } )
        result.should == [200, {"Content-Type" => "text/css"}, [File.read('assets/css/bootstrap.css')]]
      end
      it "should serve image resources" do
        result = sut.run( { "REQUEST_PATH" => "/assets/img/glyphicons-halflings.png" } )
        result.should == [200, {"Content-Type" => "image/png"}, [File.read('assets/img/glyphicons-halflings.png')]]
      end
    end
  end
end
