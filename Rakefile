# frozen_string_literal: true
require 'rake/testtask'

namespace :run do
  task :dev do
    sh 'rerun "rackup -p 9000"'
  end

  task :test do
    ENV['RACK_ENV'] = 'test'
    sh 'rerun "rackup -p 3030"'
  end
end

Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.warning = false
end
