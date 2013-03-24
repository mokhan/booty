require "acceptance_helper"

module Booty
  describe "/blah/blah" do
    navigate_to '/blah/blah/'

    xit "should say 404" do
      sut.text.include?('404 - Page Not Found').should be_true
    end
    xit "should have a title" do
      sut.title.should == '404 - Page Not Found - Booty'
    end
  end
end
