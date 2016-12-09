class HomePage
  include PageObject

  page_url  'http://localhost:9000/'

  h1(:heading)
  div(:flash_notice, class: 'alert')
  a(:new_developer, name: 'dev')
  a(:new_repository, name: 'repo')
