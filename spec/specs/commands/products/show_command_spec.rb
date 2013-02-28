require "spec_helper"

describe Booty::Products::ShowCommand do
  let(:sut) { Booty::Products::ShowCommand.new(view_engine, repository) }
  let(:repository) { fake }
  let(:view_engine) { fake }

  context "when showing the details of a product" do
    let(:request) { fake }
    let(:html) { '<html></html>' }
    let(:product) { fake }
    let(:id) { Time.now.nsec }

    before :each do
      request.stub(:path).and_return("/products/#{id}")
      repository.stub(:find_by).with(id).and_return(product)
      view_engine.stub(:render).with({:template => '/products/show.html.erb', :model => OpenStruct.new(:product => product)}).and_return(html)
    end

    let(:result) { sut.respond_to(request) }

    it "should display the details" do
      result.should == [200, {"Content-Type" => 'text/html'}, [html]]
    end
  end
end
