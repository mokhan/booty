require "acceptance_helper"

describe '/products POST' do
  navigate_to '/products/new'

  before :each do
    sut.text_field(:id => 'name').set 'blah'
    sut.button(:name => 'submit').click
  end

  it "should be able to create a new product" do
    sut.text.include? 'blah'
  end
end
