require "spec_helper"
class UrlBuilder
  def initialize(url)
    @url = url
  end
  def append(key, value)
    @param = "#{key}=#{CGI.escape(value)}"
  end
  def build
    return "#{@url}?#{@param}" if @param
    @url
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
  end
end
