lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "scalingo/version"

Gem::Specification.new do |s|
  s.name = "scalingo"
  s.version = Scalingo::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Leo Unbekandt", "Kevin Soltysiak"]
  s.email = ["leo@scalingo.com", "kevin@scalingo.com"]
  s.homepage = "https://www.scalingo.com"
  s.summary = "Ruby client for Scalingo APIs"
  s.description = "Ruby client library for the web APIs of Scalingo, a european Platform-as-a-Service"
  s.license = "MIT"

  s.metadata = {
    "bug_tracker_uri" => "https://github.com/Scalingo/scalingo-ruby-api/issues",
    "changelog_uri" => "https://github.com/Scalingo/scalingo-ruby-api/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://developers.scalingo.com/",
    "homepage_uri" => "https://www.scalingo.com/",
    "source_code_uri" => "https://github.com/Scalingo/scalingo-ruby-api",
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  s.bindir = "exe"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.test_files = Dir["spec/**/*_spec.rb"]

  s.add_dependency "activesupport", [">= 5", "< 8"]
  s.add_dependency "faraday", "~> 1.0"
  s.add_dependency "faraday_middleware", "~> 1.0"
  s.add_dependency "multi_json", ">= 1.0.3", "~> 1.0"

  s.add_development_dependency "bundler", "~> 2.0"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "standard", "~> 1.1.0"
  s.add_development_dependency "rubocop-rspec"
  s.add_development_dependency "pry", "~> 0.14.1"
  s.add_development_dependency "webmock", "~> 3.12.2"
end
