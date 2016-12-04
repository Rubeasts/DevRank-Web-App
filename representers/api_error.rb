# frozen_string_literal: true
require 'json'

class ApiErrorRepresenter < Roar::Decorator
  include Roar::JSON

  collection :errors
end
