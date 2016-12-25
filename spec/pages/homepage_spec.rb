class HomePage
  include PageObject

  page_url  'http://localhost:9000/'

  h1(:heading)
  div(:flash_notice, class: 'alert')
  a(:new_developer, name: 'dev')
  a(:new_repository, name: 'repo')
  div(:modal, class: 'modal-dialog')
  input(:input_username, id: 'developer_username')
  input(:input_owner, id: 'repository_owner')
  input(:input_repository, id: 'repository_name')
  button(:username_submit, id: 'username-form-submit')
end
