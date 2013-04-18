require 'oauth2'

module Booty
  module Sessions
    class CreateCommand < RouteCommand
      handles :uri => /^\/sessions\/create$/, :method => :POST

      def respond_to(request)
        logger.debug(request.payload)
        authorization_code = request.payload[:code]
        p authorization_code
        # use the authorization_code to get an access_token.
        # save tokens in the database.

        client = OAuth2::Client.new(ENV['GOOGLE_BOOTYCALL_CLIENT_ID'], ENV['GOOGLE_BOOTYCALL_CLIENT_SECRET'], :site => 'https://accounts.google.com', :authorize_uri => "/o/oauth2/auth", :token_url => '/o/oauth2/token')
        #token = client.auth_code.get_token(authorization_code, :redirect_uri => 'http://localhost:9292/oauth2/callback')
        token = client.auth_code.get_token(authorization_code, :redirect_uri => 'http://localhost:9292/sessions/create')
        response = token.get('https://www.googleapis.com/userinfo/email?alt=json', :params => { 'query_foo' => 'bar' })
        p response
        p response.class.name

        HtmlResponse.new(:template => '/sessions/create.html.erb', :model => response)
      end

      #[
      #{
      #"REQUEST_METHOD"=>"GET", 
      #"REQUEST_PATH"=>"/sessions/create", 
      #"QUERY_STRING"=>"state=bootycall&code=4/AwKl6PUJTS0kJ20d5thEqr03B2fV.QpUsXhD8Wk4SEnp6UAPFm0GoNREMfAI", 
      #"REQUEST_URI"=>"/sessions/create?state=bootycall&code=4/AwKl6PUJTS0kJ20d5thEqr03B2fV.QpUsXhD8Wk4SEnp6UAPFm0GoNREMfAI", 
      #"HTTP_VERSION"=>"HTTP/1.1", "HTTP_HOST"=>"localhost:9292", "HTTP_CONNECTION"=>"keep-alive", "HTTP_CACHE_CONTROL"=>"max-age=0", 
      #"HTTP_ACCEPT"=>"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", 
      #"HTTP_USER_AGENT"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31", 
      #"HTTP_X_CHROME_VARIATIONS"=>"CIO2yQEIi7bJAQiftskBCKW2yQEIp7bJAQiptskBCLO2yQEI+4PKAQiGhMoB", 
      #"HTTP_ACCEPT_ENCODING"=>"gzip,deflate,sdch", 
      #"HTTP_ACCEPT_LANGUAGE"=>"en-US,en;q=0.8", 
      #"HTTP_ACCEPT_CHARSET"=>"ISO-8859-1,utf-8;q=0.7,*;q=0.3", 
      #"HTTP_COOKIE"=>"_techtalk_session=BAh7CkkiD3Nlc3Npb25faWQGOgZFRkkiJWUxMTQxM2Q4ZGYwMGNiYTU3OWRiNTQ0MWU4NjQ4ZmQ2BjsAVEkiEF9jc3JmX3Rva2VuBjsARkkiMUpoN0EyaWhWNFZGTEtRT25tdTQrdUdWOVF4bTJrSFQ1bmgrTTRUWWZmOWM9BjsARkkiFG9tbmlhdXRoLnBhcmFtcwY7AEZ7AEkiFG9tbmlhdXRoLm9yaWdpbgY7AEYiG2h0dHA6Ly9sb2NhbGhvc3Q6MzAwMC9JIhNvbW5pYXV0aC5zdGF0ZQY7AEYiNTFlZjE0ZmViMGYwNGIzMjMzMjU2ZmUyYWU3M2IwNTk1NmQ3MjRjZDFjZmZhYTlkYg%3D%3D--c14e7b6eeb8e03c2448c489deec5d0a0211e4e6c; _cake_eater=BAh7CEkiD3Nlc3Npb25faWQGOgZFRkkiJTM4ZjhmYjZkMmQxMjBjZmFkOWY1MzU1OWI0YzEwZTYzBjsAVEkiEF9jc3JmX3Rva2VuBjsARkkiMXliejVHaDlialR4YTF3QjhLRnJ2THRLTm95Y1lwRWtBNlkrM2JYU2pJQ2s9BjsARkkiGXdhcmRlbi51c2VyLnVzZXIua2V5BjsAVFsISSIJVXNlcgY7AEZbBmkISSIiJDJhJDEwJENJd3BFVU02L2xXeHh1b0FBZktseC4GOwBU--494c9550bf983eed71171bb6d74d1d5fc02483bc", 
      #"GATEWAY_INTERFACE"=>"CGI/1.2", 
      #"SERVER_NAME"=>"localhost", 
      #"SERVER_PORT"=>"9292", 
      #"SERVER_PROTOCOL"=>"HTTP/1.1", 
      #"SERVER_SOFTWARE"=>"Mongrel 1.2.0.pre2", 
      #"PATH_INFO"=>"/sessions/create", 
      #"SCRIPT_NAME"=>"", 
      #"REMOTE_ADDR"=>"127.0.0.1", 
      #"rack.version"=>[1, 2], 
      #"rack.input"=>#<Rack::Lint::InputWrapper:0x007ffbd3137e38 @input=#<StringIO:0x007ffbd31256c0>>, 
      #"rack.errors"=>#<Rack::Lint::ErrorWrapper:0x007ffbd3137d70 @error=#<IO:<STDERR>>>, 
      #"rack.multithread"=>true, 
      #"rack.multiprocess"=>false, 
      #"rack.run_once"=>false, 
      #"rack.url_scheme"=>"http"
      #}
      #]


    end
  end
end
