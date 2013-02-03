require "spec_helper"

module Booty
  module Products
    describe IndexCommand do
      let(:sut) { IndexCommand.new(view_engine, repository) }
      let(:view_engine) { fake }
      let(:repository) { fake }

      context "when run" do
        let(:html) { '<hi>' }
        let(:products) { [fake] }

        before :each do
          view_engine.stub(:render).with({:template => '/products/index.html.erb', :model => products}).and_return(html)
          repository.stub(:find_all).and_return(products)
        end
        before :each do
          @result = sut.run({})
        end
        it "should display each product" do
          @result.should == [200, {"Content-Type" => "text/html"}, [html]]
        end
      end
    end
  end
end
