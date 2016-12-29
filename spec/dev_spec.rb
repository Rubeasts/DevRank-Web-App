# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Developer Content' do
  include PageObject::PageFactory

  before do
    unless @browser
      # @headless = Headless.new
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
    # @headless.destroy
  end


  it '(HAPPY) should see content' do
    visit DeveloperPage do |page|
      # GIVEN
      @browser.goto homepage
      page.new_developer
      @browser.text_field(:id, "developer_username").set("rjollet")
      page.username_submit

      # THEN

      page.avatar_element.visible?.must_equal true
      # @browser.div(class: 'col-md-6').count.must_be :>=, 1
    end
  end


  it '(HAPPY) should be able open the new group modal' do
    visit DeveloperPage do |page|
      # GIVEN: on the homepage
      @browser.goto homepage
      page.new_developer
      @browser.text_field(:id, "developer_username").set("rjollet")
      page.username_submit

      @browser.a(class: 'dev_btn').click
      Watir::Wait.until { @browser.div(id: 'DeveloperModal').visible? }
      @browser.input(id: 'developer_username').visible?.must_equal true
      @browser.text_field(:id, "developer_username").set("rjollet")
      page.username_submit_element.visible?.must_equal true
      page.username_submit

      # THEN: should see elements in modal window
    end
  end

  it '(HAPPY) should be able open the new group modal repo' do
    visit DeveloperPage do |page|
      # GIVEN: on the homepage

      @browser.goto homepage
      page.new_developer
      page.input_username="rjollet"
      page.username_submit

      @browser.a(class: 'repo_btn').click
      Watir::Wait.until { @browser.div(id: 'RepositoryModal').visible? }
      page.input_owner_element.visible?.must_equal true
      page.input_repository_element.visible?.must_equal true
      page.repository_submit_element.visible?.must_equal true
      @browser.text_field(:id, "repository_owner").set("rjollet")
      @browser.text_field(:id, "repository_name").set("DeepViz")
      page.repository_submit
    end
    # THEN: should see elements in modal window
  end
end
