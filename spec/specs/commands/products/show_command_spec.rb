require "spec_helper"

describe Booty::Products::ShowCommand do
  let(:sut) { Booty::Products::ShowCommand.new(view_engine, repository) }
  let(:repository) { fake }
  let(:view_engine) { fake }

  context "when showing the details of a product" do
    let(:request) { { "REQUEST_PATH"=>"/products/2", "REQUEST_METHOD" => "GET" } }
    let(:html) { '<html></html>' }
    let(:product) { fake }

    before :each do
      repository.stub(:find_by).with(2).and_return(product)
      view_engine.stub(:render).with({:template => '/products/show.html.erb', :model => OpenStruct.new(:product => product)}).and_return(html)
    end

    let(:result) { sut.run(request) }

    it "should display the details" do
      result.should == [200, {"Content-Type" => 'text/html'}, [html]]
    end
  end
end
