require "bundler/setup"
require "active_support/all"

if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.start do
    enable_coverage :branch
  end
end

require "scalingo"

pattern = File.join(File.expand_path(__dir__), "support", "**", "*.rb")

Dir[pattern].sort.each { |f| require f }

require "webmock/rspec"
WebMock.disable_net_connect!

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include_context "with the default endpoint context", type: :endpoint

  config.before(:each, type: :endpoint) do
    stub_request(:any, /localhost/)
  end
end
