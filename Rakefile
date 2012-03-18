require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require 'flay_task'
require 'flog_task'

RSpec::Core::RakeTask.new :spec do |t|
  t.rspec_opts = '--color --format=documentation'
end

namespace :features do
  Cucumber::Rake::Task.new :wip do |t|
    t.cucumber_opts = '--tags @wip --tags ~@backlog'
  end
end

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = '--tags ~@wip --tags ~@backlog'
end

FLAY_FLOG_OPTS_BLOCK = lambda do |t|
  t.dirs = ['lib']
  t.verbose = true
end

FlayTask.new &FLAY_FLOG_OPTS_BLOCK
FlogTask.new &FLAY_FLOG_OPTS_BLOCK

task :all => [:spec, :features, :flay, :flog]
task :default => :spec
