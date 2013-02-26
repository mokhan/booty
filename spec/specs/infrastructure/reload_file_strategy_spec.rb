require "spec_helper"

describe ReloadFileStrategy do
  let(:sut) { ReloadFileStrategy.new }

  context "when reloading a command" do
    let(:command) { Booty::Dashboard::IndexCommand }
    let(:result) { sut.file_path_for(command) }

    it "should load the file from its current path" do
      result.should == File.expand_path(File.join(File.dirname(__FILE__), '../../../lib/commands/dashboard/index_command.rb'))
    end
  end
end
