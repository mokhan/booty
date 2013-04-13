module Booty
  module Sessions
    class NewCommand < RouteCommand
      handles :uri => /^\/sessions\/new$/, :method => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end

      def run(request)
        HtmlResponse.new(:template => '/sessions/new.html.erb')
        #url = 'https://accounts.google.com/o/oauth2/auth?scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile&state=%2Fprofile&redirect_uri=http%3A%2F%2Flocalhost:9292/sessions/create/%2Fcode&response_type=code&client_id=740667965708.apps.googleusercontent.com&approval_prompt=force'
        #p "redirecting to #{url}"
        #RedirectResponse.new(:location => url)
      end
    end
  end
end
