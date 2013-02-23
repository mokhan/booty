require "spec_helper"

describe DomainObject do
  let(:sut) { DomainObject.new(:id => 1, :name => 'blah', :color => 'blue') }

  context "when converting to a string" do
    let(:result) { sut.to_s }

    it "should include the id" do
      result.should include "id: 1"
    end

    it "should include the name" do
      result.should include "name: blah"
    end

    it "should include the color" do
      result.should include "color: blue"
    end

    it "should include the name of the class" do
      result.should include sut.class.to_s
    end
  end
end
