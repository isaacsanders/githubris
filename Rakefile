require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new :spec do |t|
  t.rspec_opts = '--color --format=documentation'
end

task :default => :spec

namespace :features do
  Cucumber::Rake::Task.new :wip do |t|
    t.cucumber_opts = '--tags @wip --tags ~@backlog'
  end
end

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = '--tags ~@wip --tags ~@backlog'
end

