require "spec_helper"

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
    context "when resolving a single item" do
      let(:jeans) { fake }
      before :each do
        sut.register(:pants) { jeans }
        @result = sut.resolve(:pants)
      end
      it "should return the first one registered" do
        @result.should == jeans
      end
    end
    context "when resolving all items" do
      let(:jeans) { fake }
      let(:dress_pants) { fake }
      before :each do
        sut.register(:pants) { jeans }
        sut.register(:pants) { dress_pants }
        @results = sut.resolve_all(:pants)
      end
      it "should return them all" do
        @results.should == [jeans, dress_pants]
      end
    end
  end
end
