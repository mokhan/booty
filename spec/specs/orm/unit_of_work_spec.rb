require "spec_helper"

describe UnitOfWork do
  let(:sut) { UnitOfWork.new(session, context, key) }
  let(:session) { fake }
  let(:context) { fake }
  let(:key) { fake }

  context "when committing a unit of work" do
    before { sut.commit }

    it "should flush the session" do
      session.should have_received(:flush)
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
