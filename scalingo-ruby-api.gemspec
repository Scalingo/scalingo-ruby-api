lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'scalingo/version'

Gem::Specification.new do |s|
  s.name        = 'scalingo-ruby-api'
  s.version     = Scalingo::VERSION
  s.authors     = ['Leo Unbekandt', 'Geoffroy Planquart']
  s.email       = ['leo@scalingo.com', 'geoffroy@planquart.fr']

  s.homepage    = 'https://github.com/Scalingo/scalingo-ruby-api'
  s.summary     = 'Ruby API for the awesome scalingo project !'
  s.description = 'Ruby wrapper around the web API of scalingo.com'
  s.license     = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files     = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.test_files  = Dir['spec/**/*_spec.rb']

  s.add_dependency 'activesupport', '>= 5'
  s.add_dependency 'activemodel', '>= 5'
  s.add_dependency 'faraday', '~> 1.0.1'
  s.add_dependency 'faraday_middleware', '~> 1.0.0'
  s.add_dependency 'faye-websocket', '~> 0.9.2'
  s.add_dependency 'jwt', '~> 2.2.1'
  s.add_dependency 'multi_json', '>= 1.0.3', '~> 1.0'

  s.add_development_dependency "bundler", "~> 2.0"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "sinatra"
  s.add_development_dependency "pry"
  s.add_development_dependency "webmock"
end
