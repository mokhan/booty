require "spec_helper"

describe Logger do
  context "playtime" do
    it "should log stuff" do
      logger = Logger.new(STDOUT)
      logger.level = Logger::DEBUG

      logger.debug("i am logged")
      #logger.close
    end
  end
end

module Booty
  describe Log do
    context "when logging stuff" do
      let(:logger) { fake }
      let(:log_factory) { fake }

      before :each do
        log_factory.stub(:create_for).with(self).and_return(logger)
        Log.bind_to(log_factory)
        Log.for(self).debug("hi there")
      end
      it "should log to the bound logger" do
        logger.should have_received(:debug, "hi there")
      end
    end
  end
end
