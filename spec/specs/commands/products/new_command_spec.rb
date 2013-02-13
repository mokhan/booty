require "spec_helper"

describe Booty::Products::NewCommand do
  let(:sut) { Booty::Products::NewCommand.new(view_engine) }
  let(:view_engine) { fake }

  context "when run" do
    before :each do
      sut.run({})
    end
    it "should render the proper view" do
      view_engine.should have_received(:render, :template => 'products/new.html.erb')
    end
  end
end
