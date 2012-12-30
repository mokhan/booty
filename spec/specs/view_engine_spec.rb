require 'spec_helper'
require 'ostruct'

module Booty
  describe ViewEngine do
    let(:sut) { ViewEngine.new }

    context "when rendering a template" do
      before :each do
        @result = sut.render(:root_path => 'spec/specs/views/', :template => "/view_engine.html.erb", :model => OpenStruct.new(:name => 'mo'))
      end
      it "should convert the template to html" do
        @result.should == "<html>mo</html>"
      end
    end
  end
end
