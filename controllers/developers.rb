# frozen_string_literal: true

class DevRankAPP < Sinatra::Base
  extend Econfig::Shortcut

  #dev modal forms handler
  get '/dev/?' do
    dev_username_request = DevUsernameRequest.call(params)
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

  #load developer url path
  get '/dev/:developer_username/?' do
    result = LoadDeveloper.call(params)
    if result.success?
      if result.value.class == Developer
        @data = result.value
        slim :developer
      else
        puts result.value['channel_id']
        @channel = result.value['channel_id']
        slim :loading
      end
    else
      flash[:error] = result.value.message
      redirect '/'
    end
  end
end
