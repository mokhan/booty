require "spec_helper"

describe Booty::AssetResponse do
  let(:sut) { Booty::AssetResponse.new(200, "/assets/css/bootstrap.css", "text/css") }

  context "when rendering the response" do
    let(:view_engine) { fake }
    let(:result) { sut.run(view_engine) }

    it "should return the proper response" do
      result.should == [200, {"Content-Type" => "text/css"}, [File.read('assets/css/bootstrap.css')]]
    end
  end
end
