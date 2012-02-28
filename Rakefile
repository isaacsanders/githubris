require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new :spec

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = '--tags ~@wip --tags ~@backlog'
end

unless ENV['TRAVIS_CI']
  task :default => :spec
else
  RSpec::Core::RakeTask.new :spec_with_cov do |t|
    t.rspec_opts = '--color --format=documentation'
    require 'simplecov'
    SimpleCov.start do
      add_filter '/spec/'
      add_filter '/features/'
      add_filter '/pkg/'
      add_filter '/coverage/'
    end
  end

  task :default => :spec_with_cov
end

