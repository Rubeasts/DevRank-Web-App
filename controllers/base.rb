# frozen_string_literal: true

class DevRankAPP < Sinatra::Base
  extend Econfig::Shortcut

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
  end

  get '/' do
    slim :index
  end

  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  use Rack::Session::Cookie, secret: DevRankAPP.config.SECRET
  use Rack::Flash

  def self.api
    config.DEVRANK_API
  end

  after do
    content_type 'text/html'
  end
end
