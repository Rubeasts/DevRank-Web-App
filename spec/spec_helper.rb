# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'

require 'watir'
require 'headless'
require 'page-object'

require './init.rb'

HAPPY_USERNAME = 'rjollet'
SAD_USERNAME = '132452'

HOST = 'http://localhost:9000/'

# Helper methods
def homepage
  HOST
end

def group_details_page(username)
  "#{HOST}/dev/#{username}"
end