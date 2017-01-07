# frozen_string_literal: true

# Roar:Decorator for representing the developer
class QualityDataRepresenter < Roar::Decorator
  include Roar::JSON

  property :rubocop_score
  property :flog_score
  property :flay_score
end
