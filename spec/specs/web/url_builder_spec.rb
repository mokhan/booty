require "spec_helper"
class UrlBuilder
  def initialize(url)
    @url = url
    @params = []
  end
  def append(key, value)
    @params.push("#{key}=#{CGI.escape(value)}")
  end
  def build
    result = @url.clone
    result << "?" if @params.any?
    @params.each_with_index do |param,index|
      result << '&' unless index == 0
      result << param
    end
    result
  end
end

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
  end
end
