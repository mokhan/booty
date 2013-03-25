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
    if ENV['HEADLESS']
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

class BackgroundJob
  def initialize(process)
    @process = process
  end
  def start
    @pid = fork do
      exec @process
    end
  end
  def stop
    Process.kill "TERM", @pid if @pid
    Process.wait @pid if @pid
  end
end
RSpec.configure do |config|
  jobs = []
  jobs.push(BackgroundJob.new('bundle exec rackup config.ru -p 9292 -s mongrel'))

  config.before(:suite) do
    jobs.each { |job| job.start }
  end
  config.after(:suite) do
    jobs.each { |job| job.stop }
  end
end
