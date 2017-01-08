# frozen_string_literal: true

# Roar:Decorator for representing the rubocop score
class ParticipationRepresenter < Roar::Decorator
  include Roar::JSON

  property :all
  property :owner
end
