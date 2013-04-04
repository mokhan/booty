require 'spec_helper'
require 'ostruct'

module Booty
  describe ViewEngine do
    let(:sut) { ViewEngine.new(root_path: 'spec/specs/views/', master: 'master.html.erb') }

    context "when rendering a template" do
      let(:result) { sut.render(:template => "/view_engine.html.erb", :model => OpenStruct.new(:name => 'mo')) }

      it "should convert the template to html" do
        result.should == "<html><head><title>TEST</title></head><body><p>mo</p></body></html>"
      end
    end
  end
end
