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
    @browser.goto dev
    # THEN

    @browser.img(class: 'avatar').visible?.must_equal true
    @browser.div(class: 'col-md-6').count.must_be :>=, 1
  end


  it '(HAPPY) should be able open the new group modal' do
    # GIVEN: on the homepage
    @browser.goto dev

    # WHEN: click on 'new group'
    @browser.a(name: 'dev').click

    # THEN: should see elements in modal window
    Watir::Wait.until { @browser.div(class: 'modal-dialog').visible? }
    @browser.input(id: 'developer_username').visible?.must_equal true
    @browser.button(id: 'username-form-submit').visible?.must_equal true
  end

  it '(HAPPY) should be able open the new group modal repo' do
    # GIVEN: on the homepage
    @browser.goto dev

    # WHEN: click on 'new group'
    @browser.a(name: 'repo').click

    # THEN: should see elements in modal window
    Watir::Wait.until { @browser.div(class: 'modal-dialog').visible? }
    @browser.input(id: 'repository_username').visible?.must_equal true
    @browser.button(id: 'repository-form-submit').visible?.must_equal true
  end
end
