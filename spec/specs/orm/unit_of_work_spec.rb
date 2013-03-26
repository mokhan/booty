require "spec_helper"

describe UnitOfWork do
  let(:sut) { UnitOfWork.new(session, context, key) }
  let(:session) { fake }
  let(:context) { fake }
  let(:key) { fake }

  context "when running a unit of work" do
    before :each do
      sut.run do
      end
    end

    it "should forward the block to the session" do
      session.should have_received(:run)
    end
  end
  context "when ending a unit of work" do
    before { sut.dispose }

    it "should remove the key from the context" do
      context.should have_received(:remove, key)
    end

    it "should close the session" do
      session.should have_received(:dispose)
    end
  end
end
