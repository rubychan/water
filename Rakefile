require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

desc 'Run a quick test'
task :test do
  puts `git diff | ruby -rubygems -w -Ilib bin/water`
end