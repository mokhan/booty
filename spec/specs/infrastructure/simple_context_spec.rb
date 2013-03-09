require "spec_helper"
class Key
  def initialize(key)
    @key = key
  end
  def add_to(store, value)
    store[to_sym] = value
  end
  def remove_from(store)
    store[to_sym] = nil
  end
  def contained_in?(store)
    store[to_sym]
  end
  def to_sym
    @key.to_sym
  end
end
class SimpleContext
  def initialize(store)
    @store = store
  end
  def add(key, value)
    key.add_to(@store, value)
  end
  def remove(key)
    key.remove_from(@store)
  end
  def contains?(key)
    key.contained_in?(@store)
  end
end

describe SimpleContext do
  let(:sut) { SimpleContext.new(store) }
  let(:store) { Hash.new }

  context "when adding an item" do
    let(:key) { Key.new("artist") }
    let(:item) { "bobby digital" }

    before { sut.add(key, item) }

    it "should add the item to the context" do
      store[key.to_sym].should == item
    end
  end

  context "when removing an item" do
    let(:key) { Key.new("artist") }
    let(:item) { "bobby digital" }

    before :each do
      sut.add(key, item)
      sut.remove(key)
    end

    it "should remove the item from the store" do
      store[key.to_sym].should be_nil
    end
  end
  context "when checking if a key is in the context" do
    context "when it is" do
      let(:key) { Key.new("blah") }
      before { sut.add(key, 'blah') }
      let(:result) { sut.contains?(key) }

      it "should return true" do
        result.should be_true
      end
    end
    context "when it is not" do
      let(:key) { Key.new("blah") }
      let(:result) { sut.contains?(key) }

      it "should return false" do
        result.should be_false
      end
    end
  end
end

