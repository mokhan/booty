require "spec_helper"

describe UnitOfWorkFactory do
  let(:sut) { UnitOfWorkFactory.new(application_context, session_factory, key) }
  let(:application_context) { fake }
  let(:session_factory) { fake }
  let(:key) { "blah" }

  context "when creating a new unit of work" do
    let(:session) { "session" }
    before { session_factory.stub(:create).and_return(session) }

    context "when there is no running session" do
      before { application_context.stub(:contains?).with(key).and_return(false) }

      let!(:result) { sut.create }

      it "should start a new unit of work" do
        result.should be_instance_of(UnitOfWork)
      end

      it "should mark the unit of work as started" do
        application_context.should have_received(:add, key, session)
      end
    end

    context "when there is a running session" do
      before { application_context.stub(:contains?).with(key).and_return(true) }

      let(:result) { sut.create }

      it "should return an empty unit of work" do
        result.should be_instance_of(NullUnitOfWork)
      end
    end
  end
end
