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

  register :validate_username_request, lambda { |params|
    dev_username_request = DevUsernameRequest.call(params)
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
      http_result = HTTP.get("#{DevRankAPP.api}/dev/#{username}")
      Right(http_result)
    rescue
      Left(Error.new("Our servers failed to get #{username} - we are investigating!"))
    end
  }

  register :return_api_result, lambda { |http_result|
    data = JSON.parse(http_result.body.to_s)['data']
    puts data['data']
    if http_result.status == 200
      developer = DeveloperRepresenter.new(Developer.new).from_json(data)
      puts developer
      developer = add_stats_avg developer
      Right developer
    elsif http_result.status == 202
      Right JSON.parse(data)
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }

  def self.add_stats_avg(developer)
    count_flog = 0
    count_rubo = 0
    flog_sum = 0
    rubo_offense = 0
    rubo_file = 0
    developer.repositories.each do |child|
      if child.flog_score != "void"
        count_flog = count_flog + 1
        flog_sum = flog_sum + child.flog_score.total_score
      else
      end
      if child.rubocop_score != "void"
        count_rubo = count_rubo + 1
        rubo_offense = rubo_offense + child.rubocop_score.offense_count
        rubo_file = rubo_file + child.rubocop_score.inspected_file_count
      else
      end
    end

    flog_avg = count_flog == 0 ? 0 : flog_sum / count_flog
    rubo_avg = rubo_file == 0 ? 0 : rubo_offense / rubo_file
    puts flog_avg
    puts rubo_avg
    developer.flog_avg = flog_avg
    developer.rubocop_avg = rubo_avg
    developer
  end
end
