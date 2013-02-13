require "acceptance_helper"

describe "/products/new" do
  let(:sut) { Watir::Browser.new }
  before :all do
    sut.goto 'http://localhost:9292/products/new'
  end
  after :all do
    sut.close
  end
  it "should say New" do
    sut.text.include?('New Product').should be_true
  end
end
