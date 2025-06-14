require "rake/testtask"
require "bundler/gem_tasks"

task default: %i[]

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test_*.rb']
end

task default: :test
