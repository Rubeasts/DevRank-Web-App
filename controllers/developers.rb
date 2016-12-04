# frozen_string_literal: true

class DevRankAPP < Sinatra::Base
  extend Econfig::Shortcut

  get '/dev/?' do
    dev_username_request = DevUsernameRequest.call(params)
    puts dev_username_request.inspect
    if dev_username_request.success?
      redirect "/dev/#{dev_username_request[:developer_username]}"
    else
      message = ErrorFlattener.new(
        ValidationError.new(dev_username_request)
      ).to_s
      flash[:error] = Error.new(message).message
      redirect '/'
    end
  end

  get '/dev/:developer_username/?' do
    dev_username_request = DevUsernameRequest.call(params)
    result = LoadDeveloper.call(dev_username_request)
    if result.success?
      @data = result.value
      slim :developer
    else
      flash[:error] = result.value.message
      redirect '/'
    end
  end
end
