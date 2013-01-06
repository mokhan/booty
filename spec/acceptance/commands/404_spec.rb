require "spec_helper"
require 'watir-webdriver'

module Booty
  describe "/blah/blah" do
    let(:sut) { Watir::Browser.new }
    before :all do
      sut.goto 'http://localhost:9292/blah/blah/'
    end
    after :all do
      sut.close
    end
    it "should say 404" do
      sut.text.include?('404 - Page Not Found').should be_true
    end
    it "should have a title" do
      sut.title.should == '404 - Page Not Found - Booty'
    end
  end
end
