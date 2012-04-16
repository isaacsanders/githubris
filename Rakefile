require 'bundler/gem_tasks'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'flay_task'
require 'flog_task'

Bundler.setup

RSpec::Core::RakeTask.new :spec do |t|
  t.rspec_opts = '--color --format=documentation'
end

task :cov do
  ENV['COVERAGE'] = 'true'
end

FLAY_FLOG_OPTS_BLOCK = lambda do |t|
  t.dirs = ['lib']
  t.verbose = true
end

FlayTask.new &FLAY_FLOG_OPTS_BLOCK
FlogTask.new &FLAY_FLOG_OPTS_BLOCK

task :ci => [:spec]
task :specs => :spec
task :default => [:cov, :spec, :flay, :flog]
