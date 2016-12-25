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
      page.goto homepage
      page.new_developer.click
      @browser.text_field(:id, "developer_username").set("rjollet")
      page.username_submit.click

      # THEN

      @browser.img(class: 'avatar').visible?.must_equal true
      # @browser.div(class: 'col-md-6').count.must_be :>=, 1
    end
  end


  it '(HAPPY) should be able open the new group modal' do
    visit DeveloperPage do |page|
      # GIVEN: on the homepage
      page.goto homepage
      page.new_developer.click
      @browser.text_field(:id, "developer_username").set("rjollet")
      page.username_submit.click

      @browser.a(class: 'dev_btn').click
      Watir::Wait.until { @browser.div(id: 'DeveloperModal').visible? }
      @browser.input(id: 'developer_username').visible?.must_equal true
      page.username_submit.visible?.must_equal true
      @browser.text_field(:id, "developer_username").set("rjollet")
      page.username_submit.click

      # THEN: should see elements in modal window
    end
  end

  it '(HAPPY) should be able open the new group modal repo' do
    visit DeveloperPage do |page|
      # GIVEN: on the homepage

      page.goto homepage
      page.new_developer.click
      @browser.text_field(:id, "developer_username").set("rjollet")
      page.username_submit.click

      @browser.a(class: 'repo_btn').click
      Watir::Wait.until { @browser.div(id: 'RepositoryModal').visible? }
      page.input_owner.visible?.must_equal true
      page.input_repository.visible?.must_equal true
      page.username_submit.visible?.must_equal true
      @browser.text_field(:id, "repository_owner").set("rjollet")
      @browser.text_field(:id, "repository_name").set("DeepViz")
      page.username_submit.click
    end
    # THEN: should see elements in modal window
  end
end
