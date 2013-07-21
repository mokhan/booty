require "spec_helper"

module Booty
  describe UrlBuilder do
    let(:sut) { UrlBuilder.new(url) }
    let(:url) { 'https://accounts.google.com/o/oauth2/auth' }

    context "when building a simple url" do
      let(:result) { sut.build }
      it "should return the url" do
        result.should == url
      end
    end

    context "when building a url" do
      let(:result) { sut.build }

      context "with a query string param" do
        before { sut.append(:scope, "https://www.googleapis.com") }

        it "should append the query string param" do
          result.should == "#{url}?scope=https%3A%2F%2Fwww.googleapis.com"
        end
      end

      context "with different query string params" do
        before :each do
          sut.append(:scope, "https://www.googleapis.com") 
          sut.append(:redirect_uri, "https://mokhan.ca") 
        end

        it "should append the query string param" do
          result.should == "#{url}?scope=https%3A%2F%2Fwww.googleapis.com&redirect_uri=https%3A%2F%2Fmokhan.ca"
        end
      end

      context "when multiple values are added for the same key" do
        before :each do
          sut.append(:scope, 'blah')
          sut.append(:scope, 'huh')
        end
        it "should append each one correctly" do
          result.should == "#{url}?scope=blah+huh"
        end
      end
    end
  end
end
