module Booty
  describe IndexCommand do
    let(:sut) { IndexCommand.new }
    context "when a request for the root of the website is received" do
      let(:request) do 
        {
          "REQUEST_METHOD"=>"GET", 
          "REQUEST_PATH"=>"/",
          "REQUEST_URI"=>"/",
          "HTTP_VERSION"=>"HTTP/1.1",
          "HTTP_HOST"=>"localhost:9292",
          "HTTP_USER_AGENT"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20100101 Firefox/17.0",
          "HTTP_ACCEPT"=>"text/html, application/xhtml+xml, application/xml;q=0.9, */*;q=0.8",
          "HTTP_ACCEPT_LANGUAGE"=>"en-US, en;q=0.5",
          "HTTP_ACCEPT_ENCODING"=>"gzip, deflate",
          "HTTP_DNT"=>"1",
          "HTTP_CONNECTION"=>"keep-alive",
          "HTTP_COOKIE"=>"__utma=111872281.649176844.1349961094.1355984246.1356634709.36; __utmz=111872281.1349961094.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); _cake_eater=BAh7CEkiD3Nlc3Npb25faWQGOgZFRkkiJTJhYjE3NmJiY2U4NTNiZmViOGM2OGI5OTlkNjhkOWI3BjsAVEkiEF9jc3JmX3Rva2VuBjsARkkiMUZJOEdHdkdDdTVrTFd2YVUyL1o4OWpaTENWZ3VxUmtoTjFKRXJBMFRPMDg9BjsARkkiGXdhcmRlbi51c2VyLnVzZXIua2V5BjsAVFsISSIJVXNlcgY7AEZbBmkGIiIkMmEkMTAkNXIwQzJqZ2owWWI1Nlo4UVFtZ0ZLLg%3D%3D--8ff0e88e6452b2d47552f89afca115574b7a624b; __utmc=111872281",
          "HTTP_CACHE_CONTROL"=>"max-age=0",
          "GATEWAY_INTERFACE"=>"CGI/1.2",
          "SERVER_NAME"=>"localhost",
          "SERVER_PORT"=>"9292",
          "SERVER_PROTOCOL"=>"HTTP/1.1",
          "SERVER_SOFTWARE"=>"Mongrel 1.2.0.pre2",
          "PATH_INFO"=>"/",
          "SCRIPT_NAME"=>"",
          "REMOTE_ADDR"=>"127.0.0.1",
          "rack.version"=>[1, 1],
          "rack.url_scheme"=>"http",
          "QUERY_STRING"=>""
        }
      end
      before :each do
        @result = sut.matches(request)
      end
      it "should indicate that it can process the request" do
        @result.should be_true
      end
    end
  end
end
