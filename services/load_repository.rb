# frozen_string_literal: true

# Load a developer information from the API
class LoadRepository
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_repository_request
      step :call_api_to_load_repository
      step :return_api_result
    end.call(url_request)
  end

  register :validate_repository_request, lambda { |params|
    repo_owner_request = RepositoryOwnerRequest.call(params)
    if repo_owner_request.success?
      Right(repo_owner_request)
    else
      message = ErrorFlattener.new(
        ValidationError.new(repo_owner_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_load_repository, lambda { |params|
    begin
      http_result = HTTP.get("#{DevRankAPP.api}/repos/#{params[:repository_owner]}/#{params[:repository_name]}")
      Right(http_result)
    rescue
      Left(Error.new("Our servers failed to get #{params} - we are investigating!"))
    end
  }

  register :return_api_result, lambda { |http_result|
    data = http_result.body.to_s
    puts(http_result)
    puts(http_result.status)
    if http_result.status == 200
      Right(RepositoryRepresenter.new(Repository.new).from_json(data))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
end
