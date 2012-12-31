require "spec_helper"

module Booty
  describe Container do
    let(:sut) { Container.new }

    describe "when resolving an item that has been registered" do
      let(:registered_item) { Object.new }
      before :each do
        sut.register(:item) do
          registered_item
        end
      end
      before :each do
        @result = sut.resolve(:item) 
      end
      it "should return the registered item" do
        @result.should == registered_item
      end
    end
    describe "when resolving the container" do
      it "should return itself" do
        sut.resolve(:container).should == sut
      end
    end
    describe "when multiple items are registered with the same key" do
      let(:jeans) { fake }
      let(:dress_pants) { fake }
      before :each do
        sut.register(:pants) { jeans }
        sut.register(:pants) { dress_pants }
      end
      context "when resolving a single item" do
        before :each do
          @result = sut.resolve(:pants)
        end
        it "should return the first one registered" do
          @result.should == jeans
        end
      end
      context "when resolving all items" do
        before :each do
          @results = sut.resolve_all(:pants)
        end
        it "should return them all" do
          @results.should == [jeans, dress_pants]
        end
      end
      context "when resolving all items for an unknown key" do
        it "should return an empty array" do
          sut.resolve_all(:shirts).should be_empty
        end
      end
    end
    context "when a component is registered as a singleton" do
      before :each do
        sut.register(:singleton) { fake }.as_singleton
      end
      it "should return the same instance of that component each time it is resolved" do
        sut.resolve(:singleton).should == sut.resolve(:singleton)
      end
    end
    context "when invoking the factory method" do
      before :each do
        sut.register(:item){ |item| @result = item[0] }
        sut.resolve(:item)
      end
      it "should pass the container through to the block" do
        @result.should == sut
      end
    end
  end
end
