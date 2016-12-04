# frozen_string_literal: true

Repository = Struct.new :id, :github_id, :full_name, :is_private, :created_at,
                        :pushed_at, :size, :stargazers_count, :watchers_count,
                        :forks_count, :open_issues_count
