$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'katello_docker/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'katello_docker'
  s.version     = KatelloDocker::VERSION
  s.date        = Date.today.to_s
  s.authors     = []
  s.email       = []
  s.homepage    = 'http://github.com/katello/katello_docker'
  s.summary     = 'Provision and manage Docker containers and images from Katello'
  s.description = 'Provision and manage Docker containers and images from Katello.'
  s.licenses    = ['GPL-3']

  s.files = Dir['{app,config,db,lib,locale}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'foreman_docker', '~> 1.1'
end
