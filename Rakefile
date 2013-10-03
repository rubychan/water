require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

desc 'Run a quick test'
task :test do
  puts %x(git diff `git rev-list HEAD | tail -n 1` | ruby -rubygems -w -Ilib bin/water)
end
