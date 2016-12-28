# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Homepage' do
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

  describe 'Page elements' do
    it '(HAPPY) should see website features' do
      visit HomePage do |page|
        # GIVEN
        @browser.goto homepage
        page.title.must_include 'DevRank'
        page.heading.must_include 'DevRank'

        # THEN
        page.new_developer_element.visible?.must_equal true
        page.new_repository_element.visible?.must_equal true
      end
    end

    it '(HAPPY) should be able open the new group modal' do
      visit HomePage do |page|
        # GIVEN: on the homepage
        @browser.goto homepage

        # WHEN: click on 'new group'
        page.new_developer

        # THEN: should see elements in modal window
        Watir::Wait.until { @browser.div(id: 'DeveloperModal').visible? }
        page.input_username_element.visible?.must_equal true
        page.username_submit_element.visible?.must_equal true
      end
    end

    it '(HAPPY) should be able open the new group modal repo' do
      visit HomePage do |page|
        # GIVEN: on the homepage
        @browser.goto homepage

        # WHEN: click on 'new group'
        page.new_repository

        # THEN: should see elements in modal window
        Watir::Wait.until { @browser.div(id: 'RepositoryModal').visible? }
        page.input_owner_element.visible?.must_equal true
        page.input_repository_element.visible?.must_equal true
        page.repository_submit_element.visible?.must_equal true
      end
    end
  end
end
