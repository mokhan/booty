require "spec_helper"

class UnitOfWork
  def initialize(&block)
    @block = block
  end
  def run
    @block.call(self)
  end
  def commit
    
  end
  def self.create(&block)
    UnitOfWork.new(&block)
  end
end

describe UnitOfWork do
  context "when running something within a unit of work" do
    let(:command) { fake }
    let(:sut) do
      UnitOfWork.create do |unit_of_work|
        command.run
        unit_of_work.commit
      end
    end
    before :each do
      sut.run
    end
    it "should invoke the command when run" do
      command.should have_received(:run)
    end
  end
  context "when committing a unit of work" do
    it "should commit the session" do
      
    end
  end
end
