require 'spec_helper'

describe BlockMatch do
  let(:sut) { BlockMatch.new { |item| item == true } }
  context "when an item matches" do
    it "should return true" do
      sut.matches(true).should be_true
    end
  end
  context "when an item does not match" do
    it "should return true" do
      sut.matches(false).should be_false
    end
  end
end
