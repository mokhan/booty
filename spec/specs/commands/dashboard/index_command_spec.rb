module Booty
  module Dashboard
    describe IndexCommand do
      let(:sut) { IndexCommand.new }
      context "when a request for the root of the website is received" do
        context "when it's for the root of the website" do
          let(:request) { { "REQUEST_PATH"=>"/" } }
          it "should indicate that it can process the request" do
            sut.matches(request).should be_true
          end
        end
        context "when it is for another path" do
          let(:request) { { "REQUEST_PATH"=>"/hi/mo/1" } }
          it "should indicate that it cannot process the request" do
            sut.matches(request).should be_false
          end
        end
      end
    end
  end
end
