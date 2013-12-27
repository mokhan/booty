require_relative 'lib/booty.rb'

use Rack::Deflater
use Rack::Static, :urls => ["/images", "/js", "/css"], :root => "assets"
run Booty::Application.run
