# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'scalingo/version'

Gem::Specification.new do |s|
  s.license     = 'MIT'
  s.name        = 'scalingo-ruby-api'
  s.version     = Scalingo::VERSION
  s.authors     = ['Geoffroy Planquart']
  s.email       = ['geoffroy@planquart.fr']
  s.homepage    = 'https://github.com/Aethelflaed/scalingo-ruby-api'
  s.summary     = 'Ruby API for the awesome scalingo project !'
  s.description = 'Ruby wrapper around the web API of scalingo.io'

  s.files       = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files  = Dir['test/**/*']

  s.add_dependency 'faraday', ['>= 0.7', '<= 0.9']
  s.add_dependency 'faraday_middleware', '~> 0.8'
  s.add_dependency 'multi_json', '>= 1.0.3', '~> 1.0'
  s.add_dependency 'faye-websocket', '~> 0.9.2'
end

