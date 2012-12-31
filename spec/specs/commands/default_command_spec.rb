require "spec_helper"

module Booty
  describe DefaultCommand do
    let(:sut) { DefaultCommand.new(view_engine) }
    let(:view_engine) { fake }

    context "when checking if it can process the request" do
      it "should return true" do
        sut.matches({}).should be_true
      end
    end
  end
end
