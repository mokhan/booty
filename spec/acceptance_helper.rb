require "spec_helper"
require 'watir-webdriver'

def navigate_to(url, &block)
  before :all do
    TestDatabaseGateway.delete_all
    block.call if block_given?
    headless.start
    sut.goto "http://localhost:9292#{url}"
  end

  after :all do
    sut.close
    headless.destroy
  end

  def headless
    if ENV['HEADLESS']
      require 'headless'
      p 'running HEADLESSly'
      @headless ||= OpenStruct.new(:start => true, :destroy => true)
    else
      @headless ||= Headless.new
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
