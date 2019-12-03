# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'scalingo/version'

Gem::Specification.new do |s|
  s.license     = 'MIT'
  s.name        = 'scalingo-ruby-api'
  s.version     = Scalingo::VERSION
  s.authors     = ['Leo Unbekandt', 'Geoffroy Planquart']
  s.email       = ['leo@scalingo.com', 'geoffroy@planquart.fr']
  s.homepage    = 'https://github.com/Scalingo/scalingo-ruby-api'
  s.summary     = 'Ruby API for the awesome scalingo project !'
  s.description = 'Ruby wrapper around the web API of scalingo.io'

  s.files       = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files  = Dir['test/**/*']

  s.add_dependency 'faraday', ['>= 0.7', '<= 0.17.0']
  s.add_dependency 'faraday_middleware', '~> 0.13'
  s.add_dependency 'multi_json', '>= 1.0.3', '~> 1.0'
  s.add_dependency 'faye-websocket', '~> 0.9.2'
  s.add_dependency 'activesupport', ['>= 4', '< 6']
end

