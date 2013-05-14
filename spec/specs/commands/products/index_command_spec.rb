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
          repository.stub(:find_all).and_return(products)
        end

        before :each do
          @result = sut.run({})
        end

        it "should return the proper status" do
          @result.status.should == 200
        end

        it "should return the proper model" do
          @result.model.should == products
        end

        it "should render the proper view" do
          @result.template.should == '/products/index'
        end
      end
    end
  end
end
