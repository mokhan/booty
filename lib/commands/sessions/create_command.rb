require 'oauth2'

module Booty
  module Sessions
    class CreateCommand < RouteCommand
      handles :uri => /^\/sessions\/create$/, :method => :POST

      def respond_to(request)
        HtmlResponse.new(:template => '/sessions/create', :model => fetch_response_for(request.payload[:code]))
      end

      private

      def create_client
        OAuth2::Client.new(ENV['GOOGLE_BOOTYCALL_CLIENT_ID'], ENV['GOOGLE_BOOTYCALL_CLIENT_SECRET'], 
                           :site => 'https://accounts.google.com', 
                           :authorize_uri => "/o/oauth2/auth", 
                           :token_url => '/o/oauth2/token')
      end

      def fetch_token_for(authorization_code)
        token = create_client.auth_code.get_token(authorization_code, :redirect_uri => 'http://localhost:9292/sessions/create')
      end

      def fetch_response_for(authorization_code)
        #fetch_token_for(authorization_code).get('https://www.googleapis.com/userinfo/email?alt=json', :params => { 'query_foo' => 'bar' })
        fetch_token_for(authorization_code).get('https://www.googleapis.com/oauth2/v1/userinfo', :params => { 'query_foo' => 'bar' })
      end
    end
  end
end
