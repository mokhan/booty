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
    end

    let(:result) { sut.respond_to(request) }

    it "should return the proper status" do
      result.status.should == 200
    end

    it "should return the proper model" do
      result.model.should == product
    end

    it "should render the correct view" do
      result.template.should == '/products/show.html.erb'
    end
  end
end
