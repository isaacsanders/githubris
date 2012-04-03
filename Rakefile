require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'flay_task'
require 'flog_task'

RSpec::Core::RakeTask.new :spec do |t|
  t.rspec_opts = '--color --format=documentation'
end

FLAY_FLOG_OPTS_BLOCK = lambda do |t|
  t.dirs = ['lib']
  t.verbose = true
end

FlayTask.new &FLAY_FLOG_OPTS_BLOCK
FlogTask.new &FLAY_FLOG_OPTS_BLOCK

task :ci => [:spec]
task :all => [:ci, :flay, :flog]
task :default => :spec
