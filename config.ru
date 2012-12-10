$: << 'lib'

require 'sinatra'
require 'rack/ssl'
# require 'travis/assets'

class App < Sinatra::Base
  disable :protection

  set :root, File.dirname(__FILE__)
  set :public_folder, lambda { "#{root}/public" }
  set :static_cache_control, :public

  # configure :development do
  #   $: << 'lib'
  #   require 'travis/assets'
  #   use Travis::Assets::Middleware, settings.root
  # end

  get '/' do
    File.new('public/index.html').readlines
  end

  not_found do
    'Not found.'
  end
end

use Rack::SSL
use Rack::Deflater
run App
