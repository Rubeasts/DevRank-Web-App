# frozen_string_literal: true
require_relative "participation"

# Roar:Decorator for representing the stats
class StatRepresenter < Roar::Decorator
  include Roar::JSON

  property :code_frequency
  property :participation
end
