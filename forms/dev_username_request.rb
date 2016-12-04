# frozen_string_literal: true

DevUsernameRequest = Dry::Validation.Form do
  required(:developer_username).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/dev_username_request.yml')
  end
end
