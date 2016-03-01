require "bundler/setup"
require 'rake/testtask'
require "./site"

task default: :test

desc "Run a local server."
task :local do
  Kernel.exec("shotgun -s thin -p 9393")
end

Rake::TestTask.new do |t|
  t.pattern = "tests/*_test.rb"
end
