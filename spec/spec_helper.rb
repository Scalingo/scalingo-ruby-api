require "bundler/setup"
require "scalingo"

pattern = File.join(File.expand_path(__dir__), "support", "**", "*.rb")

Dir[pattern].sort.each { |f| require f }

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Scalingo::StubHelpers

  config.before(:example) do |example|
    if defined?(stub_pattern)
      register_stubs!(stub_pattern)
    end
  end
end
