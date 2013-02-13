require "spec_helper"
require 'watir-webdriver'

def navigate_to(url, &block)
  let(:sut) { Watir::Browser.new }
  before :all do
    block.call if block_given?
    sut.goto url
  end
  after :all do
    sut.close
    TestDatabaseGateway.delete_all
  end
end
