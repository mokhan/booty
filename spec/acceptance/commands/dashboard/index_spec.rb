require "acceptance_helper"

module Booty
  describe "/" do
    navigate_to '/'

    it "should say hello world" do
      sut.text.include?('Hello, world!').should be_true
    end
    it "should have a title" do
      sut.title.should == 'Hello World - Booty'
    end
  end
end
