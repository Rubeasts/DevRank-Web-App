# frozen_string_literal: true

# Load a developer information from the API
class LoadDeveloper
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_username_request
      step :call_api_to_load_developer
      step :return_api_result
    end.call(url_request)
  end

  register :validate_username_request, lambda { |dev_username_request|
    if dev_username_request.success?
      Right(dev_username_request[:developer_username])
    else
      message = ErrorFlattener.new(
        ValidationError.new(dev_username_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_load_developer, lambda { |username|
    begin
      http_result = HTTP.get("#{DevRankAPP.config.DEVRANK_API}/dev/#{username}")
      Right(http_result)
    rescue
      Left(Error.new('Our servers failed to get #{username} - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |http_result|
    data = http_result.body.to_s
    if http_result.status == 200
      Right(DeveloperRepresenter.new(Developer.new).from_json(data))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
end
