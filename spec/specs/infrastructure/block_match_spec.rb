require 'spec_helper'

module Booty
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
    describe "or" do
      context "when one item matches" do
        it "should return true" do
          sut.or(BlockMatch.new {|x| x == false} ).matches(false).should be_true
        end
        it "should return true" do
          sut.or {|x| x == false} .matches(false).should be_true
        end
      end
      context "when the other item matches" do
        it "should return true" do
          sut.or(BlockMatch.new {|x| x == false} ).matches(true).should be_true
        end
        it "should return true" do
          sut.or {|x| x == false} .matches(true).should be_true
        end
      end
      context "when neither item matches" do
        it "should return false" do
          sut.or(BlockMatch.new {|x| x == true}).matches(false).should be_false
        end
        it "should return false" do
          sut.or {|x| x == true}.matches(false).should be_false
        end
      end
    end
  end
end
