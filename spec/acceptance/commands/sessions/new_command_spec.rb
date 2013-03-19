require "acceptance_helper"

describe "/sessions/new" do
  navigate_to '/sessions/new'

  it "should render the login page" do
    sut.text.include?('Login').should be_true
  end
end
