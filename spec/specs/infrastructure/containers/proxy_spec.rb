require "spec_helper"

module Booty
  describe Proxy do
    let(:sut) { Proxy.new(target) }
    let(:target) { fake }

    context "when invoking a method" do
      before :each do
        sut.greet('blah')
      end
      it "should send the message to the target" do
        target.should have_received(:greet)
      end
    end
  end
end
