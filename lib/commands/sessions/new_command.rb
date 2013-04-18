module Booty
  module Sessions
    class NewCommand < RouteCommand
      handles :uri => /^\/sessions\/new$/, :method => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end

      def run(request)
        RedirectResponse.new(:location => build_redirect_url.build)
      end

      private

      def build_redirect_url
        UrlBuilder.new('https://accounts.google.com/o/oauth2/auth')
        .append(:response_type, 'code')
        .append(:client_id, ENV['GOOGLE_BOOTYCALL_CLIENT_ID'])
        .append(:redirect_uri, 'http://localhost:9292/sessions/create')
        .append(:scope, 'https://www.googleapis.com/auth/userinfo.email')
        .append(:scope, 'https://www.googleapis.com/auth/userinfo.profile')
        .append(:state, 'bootycall')
        .append(:access_type, 'offline')
        .append(:approval_prompt, 'force')
      end
    end
  end
end
