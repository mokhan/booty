require 'spec_helper'

module Booty
  module Dashboard
    describe IndexCommand do
      let(:sut) { IndexCommand.new(view_engine) }
      let(:view_engine) { fake }
      context "when a request for the root of the website is received" do
        context "when it's for the root of the website" do
          let(:request) { { "REQUEST_PATH"=>"/", "REQUEST_METHOD" => "GET" } }
          it "should indicate that it can process the request" do
            sut.matches(request).should be_true
          end
          it "should have a class method that matches the request" do
            IndexCommand.matches(request).should be_true
          end
        end
        context "when it is for another path" do
          let(:request) { { "REQUEST_PATH"=>"/hi/mo/1", "REQUEST_METHOD" => "GET" } }
          it "should indicate that it cannot process the request" do
            sut.matches(request).should be_false
          end
          it "should have a class method that does not match the request" do
            IndexCommand.matches(request).should be_false
          end
        end
      end
      context "when rendering the home page" do
        let(:html) { "<html></html>" }
        before :each do
          view_engine.stub(:render).with(:template => "/dashboard/index.html.erb").and_return(html)
        end
        before :each do
          @result = sut.run(nil)
        end
        it "should display the correct view" do
          @result.should == [200, {"Content-Type" => "text/html"}, [html]]
        end
      end
    end
  end
end
