require "spec_helper"
require 'watir-webdriver'

def navigate_to(url, &block)
  before :all do
    TestDatabaseGateway.delete_all
    block.call if block_given?
    headless.start
    sut.goto "http://localhost:9292#{url}"
  end

  after :each do
    if example.exception
      p "FAILED with #{example.exception}"
      sut.screenshot.save "tmp/#{Time.now.strftime('%Y%m%d%H%M%S%L')}-screenshot.png"
    end
  end

  after :all do
    sut.close if sut
    headless.destroy if headless
  end

  def headless
    if ENV['CI']
      require 'headless'
      @headless ||= Headless.new
    else
      @headless ||= OpenStruct.new(:start => true, :destroy => true)
    end
  end

  def sut
    @sut ||= Watir::Browser.new
  end
end

RSpec.configure do |config|
  jobs = []
  jobs.push(Nasty::BackgroundJob.new('bundle exec rackup config.ru -p 9292 -s mongrel'))

  config.before(:suite) do
    jobs.each { |job| job.run }
  end
  config.after(:suite) do
    jobs.each { |job| job.stop }
  end
end
