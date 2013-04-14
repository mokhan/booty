module Booty
  module Sessions
    class NewCommand < RouteCommand
      handles :uri => /^\/sessions\/new$/, :method => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end

      def run(request)
        #HtmlResponse.new(:template => '/sessions/new.html.erb')
        RedirectResponse.new(:location => build_redirect_url.build)
      end

      private

      def build_redirect_url
        url_builder = UrlBuilder.new('https://accounts.google.com/o/oauth2/auth')
        url_builder.append(:response_type, 'code')
        url_builder.append(:client_id, ENV['GOOGLE_BOOTYCALL_CLIENT_ID'])
        url_builder.append(:redirect_uri, 'http://localhost:9292/sessions/create')
        url_builder.append(:scope, 'https://www.googleapis.com/auth/userinfo.email')
        url_builder.append(:scope, 'https://www.googleapis.com/auth/userinfo.profile')
        url_builder.append(:state, 'bootycall')
        url_builder.append(:access_type, 'offline')
        url_builder.append(:approval_prompt, 'force')
        url_builder
      end
    end
  end
end
