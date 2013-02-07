require "spec_helper"
require 'watir-webdriver'

module Booty
  describe "/products" do
    let(:sut) { Watir::Browser.new }
    before :all do
      sut.goto 'http://localhost:9292/products'
    end
    after :all do
      sut.close
    end
    it "should say hello world" do
      sut.text.include?('Products').should be_true
    end
    it "should have a title" do
      sut.title.should == 'Products - Booty'
    end
  end
end
