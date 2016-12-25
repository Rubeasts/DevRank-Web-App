# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Developer Content' do

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
    # GIVEN
    @browser.goto homepage
    @browser.a(name: 'dev').click
    @browser.text_field(:id, "developer_username").set("rjollet")
    @browser.button(:id,"username-form-submit").click

    # THEN

    @browser.img(class: 'avatar').visible?.must_equal true
    # @browser.div(class: 'col-md-6').count.must_be :>=, 1
  end


  it '(HAPPY) should be able open the new group modal' do
    # GIVEN: on the homepage
    @browser.goto homepage
    @browser.a(name: 'dev').click
    @browser.text_field(:id, "developer_username").set("rjollet")
    @browser.button(:id,"username-form-submit").click

    @browser.a(class: 'dev_btn').click
    Watir::Wait.until { @browser.div(id: 'DeveloperModal').visible? }
    @browser.input(id: 'developer_username').visible?.must_equal true
    @browser.button(id: 'username-form-submit').visible?.must_equal true
    @browser.text_field(:id, "developer_username").set("rjollet")
    @browser.button(:id,"username-form-submit").click

    # THEN: should see elements in modal window

  end

  it '(HAPPY) should be able open the new group modal repo' do
    # GIVEN: on the homepage

    @browser.goto homepage
    @browser.a(name: 'dev').click
    @browser.text_field(:id, "developer_username").set("rjollet")
    @browser.button(:id,"username-form-submit").click
    
    @browser.a(class: 'repo_btn').click
    Watir::Wait.until { @browser.div(id: 'RepositoryModal').visible? }
    @browser.input(id: 'repository_owner').visible?.must_equal true
    @browser.input(id: 'repository_name').visible?.must_equal true
    @browser.button(id: 'repository-form-submit').visible?.must_equal true
    @browser.text_field(:id, "repository_owner").set("rjollet")
    @browser.text_field(:id, "repository_name").set("DeepViz")
    @browser.button(:id,"repository-form-submit").click

    # THEN: should see elements in modal window
  end
end
