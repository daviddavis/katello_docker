require File.expand_path("../engine", File.dirname(__FILE__))
namespace :test do
  desc "Run the plugin unit test suite."
  task :docker => ['db:test:prepare'] do
    test_task = Rake::TestTask.new('docker_test_task') do |t|
      t.libs << ["test", "#{KatelloDocker::Engine.root}/test"]
      t.test_files = [
        "#{KatelloDocker::Engine.root}/test/**/*_test.rb"
      ]
      t.verbose = true
    end

    Rake::Task[test_task.name].invoke
  end
end

namespace :docker do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_docker) do |task|
        task.patterns = ["#{KatelloDocker::Engine.root}/app/**/*.rb",
                         "#{KatelloDocker::Engine.root}/lib/**/*.rb",
                         "#{KatelloDocker::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts "Rubocop not loaded."
    end

    Rake::Task['rubocop_docker'].invoke
  end
end

Rake::Task[:test].enhance do
  Rake::Task['test:docker'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task["jenkins:unit"].enhance do
    Rake::Task['test:docker'].invoke
    Rake::Task['docker:rubocop'].invoke
  end
end
