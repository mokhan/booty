require "acceptance_helper"

describe "/products/new" do
  navigate_to 'http://localhost:9292/products/new'

  it "should say New" do
    sut.text.include?('New Product').should be_true
  end
end
