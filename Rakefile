require 'bundler/gem_tasks'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'flay_task'
require 'flog_task'
require 'pry'

Bundler.setup

task :console do
  Bundler.require
  pry
end

RSpec::Core::RakeTask.new :spec_no_cov do |t|
  t.rspec_opts = '--color --format=documentation'
end

task :cov do
  ENV['COVERAGE'] = 'true'
end

FLAY_FLOG_OPTS_BLOCK = lambda do |t|
  t.dirs = ['lib']
  t.verbose = true
  t.threshold = 1000
end

FlayTask.new &FLAY_FLOG_OPTS_BLOCK
FlogTask.new &FLAY_FLOG_OPTS_BLOCK

task :ci => [:spec_no_cov]
task :spec => [:cov, :spec_no_cov]
task :default => [:cov, :spec, :flay, :flog]
