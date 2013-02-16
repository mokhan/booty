require "spec_helper"
require 'watir-webdriver'

def navigate_to(url, &block)
  let(:sut) { Watir::Browser.new }
  before :all do
    block.call if block_given?
    sut.goto "http://localhost:9292#{url}"
  end
  after :all do
    sut.close
    TestDatabaseGateway.delete_all
  end
end
class Background
  def self.pid=(new_pid)
    @@pid = new_pid
  end
  def self.pid
    @@pid
  end
end
RSpec.configure do |config|
  config.before(:suite) do
    Background.pid = fork do
      exec 'rackup'
    end
  end
  config.after(:suite) do
    Process.kill "TERM", Background.pid
    Process.wait Background.pid
  end
end
