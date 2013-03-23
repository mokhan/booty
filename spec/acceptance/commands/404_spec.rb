require "acceptance_helper"

module Booty
  describe "/blah/blah" do
    navigate_to '/blah/blah/'

    it "should say 404" do
      sut.text.include?('404 - Page Not Found').should be_true
    end
    it "should have a title" do
      p "PAGE TITLE: #{sut.title}"
      p sut.text
      sut.title.should == '404 - Page Not Found - Booty'
    end
  end
end
