class RepositoryPage
  include PageObject

  page_url  'http://localhost:9000/'

  h1(:heading)
  div(:flash_notice, class: 'alert')
  a(:new_developer, name: 'dev')
  a(:new_repository, name: 'repo')
  img(:avatar, class: 'avatar')
  div(:repository_block, class: 'col-md-6')
  input(:developer_username, id: 'developer_username')
  button(:developer_submit, id: 'username-form-submit')
end
