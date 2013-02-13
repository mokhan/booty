require "spec_helper"

module Booty
  describe "routing" do
    let(:registry) { CommandRegistry.new }
    let(:container) { Booty::Container.new }

    before :each do
      BootstrapContainer.new(container).run
      BootstrapRouting.new(registry, container).run
    end

    it "should route to the dashboard" do
      registry.command_for({ "REQUEST_PATH" => "/", "REQUEST_METHOD" => "GET" }).command.should be_instance_of(Booty::Dashboard::IndexCommand)
    end

    it "should route to the 404 handler" do
      registry.command_for({ "REQUEST_PATH" => "/blah/blah" }).command.should be_instance_of(Booty::DefaultCommand)
    end
  end
end
