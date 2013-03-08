require "spec_helper"

describe UnitOfWorkFactory do
  let(:sut) { UnitOfWorkFactory.new(context, session_factory, key) }
  let(:context) { fake }
  let(:session_factory) { fake }
  let(:key) { fake }

  context "when creating a new unit of work" do
    let(:session) { fake }
    before :each do
      session_factory.stub(:create).and_return(session)
    end
    let(:result) { sut.create }

    context "when there is no running session" do
      before { context.stub(:contains?).with(key).and_return(false) }

      it "should return a new instance" do
        result.should be_instance_of(UnitOfWork)
      end
    end
    context "when there is a running session" do
      before { context.stub(:contains?).with(key).and_return(true) }

      it "should return an empty unit of work" do
        result.should be_instance_of(NullUnitOfWork)
      end
    end
  end
end
