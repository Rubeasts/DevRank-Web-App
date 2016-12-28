class RepositoryPage
  include PageObject

  page_url  'http://localhost:9000/'

  h1(:heading)
  div(:flash_notice, class: 'alert')
  link(:new_developer, name: 'dev')
  link(:new_repository, name: 'repo')
  img(:avatar, class: 'avatar')
  div(:repository_block, class: 'col-md-6')
  text_field(:developer_username, id: 'developer_username')
  button(:developer_submit, id: 'username-form-submit')
end
