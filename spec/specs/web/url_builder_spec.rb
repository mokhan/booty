require "spec_helper"
class UrlBuilder
  def initialize(url)
    @url = url
    @params = Hash.new()
  end
  def append(key, value)
    @params[key] = [] unless @params.has_key?(key)
    @params[key].push(CGI.escape(value))
  end
  def build
    result = @url.clone
    result << "?" if @params.keys.any?
    @params.keys.each_with_index do |key, i|
      result << "&" unless i == 0
      result << "#{key}="
      @params[key].each_with_index do |value,index|
        result << "+" unless index == 0
        result << value.to_s
      end
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
