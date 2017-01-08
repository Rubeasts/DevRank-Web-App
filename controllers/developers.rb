# frozen_string_literal: true
data = {
  labels: ["January", "February", "March", "April", "May", "June", "July"],
  datasets: [
    {
        label: "My First dataset",
        backgroundColor: "rgba(220,220,220,0.2)",
        borderColor: "rgba(220,220,220,1)",
        data: [65, 59, 80, 81, 56, 55, 40]
    },
    {
        label: "My Second dataset",
        backgroundColor: "rgba(151,187,205,0.2)",
        borderColor: "rgba(151,187,205,1)",
        data: [28, 48, 40, 19, 86, 27, 90]
    }
  ]
}

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
