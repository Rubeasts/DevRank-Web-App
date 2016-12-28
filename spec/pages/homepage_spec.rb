class HomePage
  include PageObject

  page_url  'http://localhost:9000/'

  h1(:heading)
  div(:flash_notice, class: 'alert')
  link(:new_developer, name: 'dev')
  link(:new_repository, name: 'repo')
  div(:modal, class: 'modal-dialog')
  text_field(:input_username, id: 'developer_username')
  text_field(:input_owner, id: 'repository_owner')
  text_field(:input_repository, id: 'repository_name')
  button(:username_submit, id: 'username-form-submit')
  button(:repository_submit, id: 'repository-form-submit')
end
