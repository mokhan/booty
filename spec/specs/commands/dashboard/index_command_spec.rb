module Booty
  module Dashboard
    describe IndexCommand do
      let(:sut) { IndexCommand.new }
      context "when a request for the root of the website is received" do
        context "when it's for the root of the website" do
          let(:request) do 
            {
              "REQUEST_PATH"=>"/",
              "REQUEST_URI"=>"/",
              "QUERY_STRING"=>""
            }
          end
          before :each do
            @result = sut.matches(request)
          end
          it "should indicate that it can process the request" do
            @result.should be_true
          end
        end
        context "when it is for another path" do
          let(:request) do
            {
              "REQUEST_PATH"=>"/hi/mo/1",
              "REQUEST_URI"=>"/hi/mo/1?name=mo",
              "QUERY_STRING"=>"name=mo"
            }
          end
          it "should indicate that it cannot process the request" do
            sut.matches(request).should be_false
          end
        end
      end
    end
  end
end
