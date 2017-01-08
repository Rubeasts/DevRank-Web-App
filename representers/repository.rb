# frozen_string_literal: true
require_relative "flog_score"
require_relative "rubocop_score"

# Roar:Decorator for representing the developer
class RepositoryRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :github_id
  property :full_name
  property :is_private
  property :created_at
  property :pushed_at
  property :size
  property :stargazers_count
  property :watchers_count
  property :forks_count
  property :open_issues_count
  property :flog_score, class: FlogScore, extend: FlogScoreRepresenter, default: "n/a"
  property :flay_score, default: "n/a"
  property :rubocop_score, class: RubocopScore, extend: RubocopScoreRepresenter, default: "n/a"
  property :language
end
