# frozen_string_literal: true

RepositoryOwnerRequest = Dry::Validation.Form do
  required(:repository_owner).filled
  required(:repository_name).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/repo_owner_request.yml')
  end
end
