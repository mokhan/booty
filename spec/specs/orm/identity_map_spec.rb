require "spec_helper"
class IdentityMap
  def initialize(items = {})
    @items = items
  end
  def add(item)
    @items[item.id] = item
  end
  def has_item_for?(id)
    @items.has_key?(id)
  end
  def item_for(id)
    @items[id]
  end
  def evict(item)
    @items.reject! { |key, value| key == item.id }
  end
end

describe IdentityMap do
  let(:sut) { IdentityMap.new }

  context "when an item is added" do
    let(:item) { Item.new(:id => 187) }
    before :each do
      sut.add(item)
    end
    it "should indicate that an item with that id is available" do
      sut.has_item_for?(item.id).should be_true
    end
    it "should be able to load the item" do
      sut.item_for(item.id).should == item
    end
    context "when an item is evicted" do
      before :each do
        sut.evict(item)
      end
      it "should indicate that it does not have an item for the evicted id" do
        sut.has_item_for?(item.id).should be_false
      end
      it "should not be able to run the evicted item" do
        sut.item_for(item.id).should be_nil
      end
    end
  end
  context "when no items have been added" do
    it "should indicate that it does not have any items for any id" do
      (0..10).each do |i|
        sut.has_item_for?(i).should be_false
      end
    end
  end
  class Item
    attr_reader :id
    def initialize(attributes)
      @id = attributes[:id]
    end
  end
end
