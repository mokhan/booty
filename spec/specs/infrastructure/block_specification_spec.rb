require 'spec_helper'

module Booty
  describe BlockSpecification do
    let(:sut) { BlockSpecification.new { |item| item == true } }
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
          sut.or(BlockSpecification.new {|x| x == false} ).matches(false).should be_true
        end
        it "should return true" do
          sut.or {|x| x == false} .matches(false).should be_true
        end
      end
      context "when the other item matches" do
        it "should return true" do
          sut.or(BlockSpecification.new {|x| x == false} ).matches(true).should be_true
        end
        it "should return true" do
          sut.or {|x| x == false} .matches(true).should be_true
        end
      end
      context "when neither item matches" do
        it "should return false" do
          sut.or(BlockSpecification.new {|x| x == true}).matches(false).should be_false
        end
        it "should return false" do
          sut.or {|x| x == true}.matches(false).should be_false
        end
      end
    end
    describe "and" do
      context "when one item matches" do
        it "should return false" do
          sut.and(BlockSpecification.new {|x| x == false} ).matches(false).should be_false
        end
        it "should return false" do
          sut.and {|x| x == false} .matches(false).should be_false
        end
      end
      context "when the other item matches" do
        it "should return false" do
          sut.and(BlockSpecification.new {|x| x == false} ).matches(true).should be_false
        end
        it "should return false" do
          sut.and {|x| x == false} .matches(true).should be_false
        end
      end
      context "when neither item matches" do
        it "should return false" do
          sut.and(BlockSpecification.new {|x| x == true}).matches(false).should be_false
        end
        it "should return false" do
          sut.and {|x| x == true}.matches(false).should be_false
        end
      end
      context "when both items match" do
        it "should return true" do
          sut.and(BlockSpecification.new {|x| x == true}).matches(true).should be_true
        end
        it "should return true" do
          sut.and {|x| x == true}.matches(true).should be_true
        end
      end
    end
    describe "not" do
      context "when an item matches" do
        it "should return false" do
          sut.not.matches(true).should be_false
        end
      end
      context "when an item does not match" do
        it "should return true" do
          sut.not.matches(false).should be_true
        end
      end
    end
  end
end
