require 'spec_helper'

module Booty
  module Dashboard
    describe IndexCommand do
      let(:sut) { IndexCommand.new(view_engine, users_repository) }
      let(:view_engine) { fake }
      let(:users_repository) { fake }

      context "when a request for the root of the website is received" do
        context "when it's for the root of the website" do
          let(:request) { { "REQUEST_PATH"=>"/", "REQUEST_METHOD" => "GET" } }

          it "should indicate that it can process the request" do
            sut.matches?(request).should be_true
          end

          it "should have a class method that matches the request" do
            IndexCommand.matches?(request).should be_true
          end
        end

        context "when it is for another path" do
          let(:request) { { "REQUEST_PATH"=>"/hi/mo/1", "REQUEST_METHOD" => "GET" } }

          it "should indicate that it cannot process the request" do
            sut.matches?(request).should be_false
          end

          it "should have a class method that does not match the request" do
            IndexCommand.matches?(request).should be_false
          end
        end
      end

      context "when rendering the home page" do
        let(:html) { "<html></html>" }
        let(:request) { fake }

        before :each do
          request.stub(:cookies).and_return({})
          view_engine.stub(:render).with(:template => "/dashboard/index").and_return(html)
        end

        let(:result) { sut.respond_to(request) }

        it "should return the proper status" do
          result.status.should == 200
        end

        it "should return the proper template" do
          result.template.should == "/dashboard/index"
        end
      end
    end
  end
end
