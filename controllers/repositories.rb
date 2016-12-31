# frozen_string_literal: true

class DevRankAPP < Sinatra::Base

  #dev modal forms handler
  get '/repos/?' do
    repo_owner_request = RepositoryOwnerRequest.call(params)
    if repo_owner_request.success?
      redirect "/repos/#{repo_owner_request[:repository_owner]}/#{repo_owner_request[:repository_name]}"
    else
      message = ErrorFlattener.new(
        ValidationError.new(repo_owner_request)
      ).to_s
      flash[:error] = Error.new(message).message
      redirect '/'
    end
  end

  #load developer url path
  get '/repos/:repository_owner/:repository_name/?' do
    result = LoadRepository.call(params)
    if result.success?
      @data = result.value
      slim :repository
    else
      flash[:error] = result.value.message
      redirect '/'
    end
  end
end
