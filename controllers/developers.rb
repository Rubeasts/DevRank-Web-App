class DevRankAPP < Sinatra::Base
  extend Econfig::Shortcut

  get '/username?' do
    result = GetDeveloper.call(params[:developer_username])
    if result.success?
      @data = result.value
    else
      flash[:error] = result.value.message
    end

    slim :username
  end

  put '/username/?' do
  	url_request = UrlRequest.call(params)
  	result = CreateNewGroup.call(url_request)

  	if result.success?
  	  flash[:notice] = 'Group successfully added'
  	else
  	  flash[:error] = result.value.message
  	end

  	redirect '/username/#{result.name}'
  end
end
