 class DevRankAPP < Sinatra::Base
  extend Econfig::Shortcut

  get '/repository?' do
   result = GetRepository.call(params[:repository_username, :repository_name])
   if result.success?
     @data = result.value
   else
     flash[:error] = result.value.message
   end

   slim :repository
  end

  put '/repository/?' do
   url_request = UrlRequest.call(params)
   result = CreateNewGroup.call(url_request)

   if result.success?
     flash[:notice] = 'Group successfully added'
   else
     flash[:error] = result.value.message
   end

   redirect '/repository/#{result.name}'
  end
end
