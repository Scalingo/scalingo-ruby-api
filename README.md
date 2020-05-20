# Scalingo Ruby API

A ruby wrapper for the Scalingo API

## Installation

```ruby
gem 'scalingo-ruby-api',  git: 'https://github.com/Scalingo/scalingo-ruby-api', branch: 'v3-dev'
```

And then execute:

```
bundle
```

## Usage

```ruby
require "scalingo"

scalingo = Scalingo::Client.new
scalingo.authenticate_with(access_token: ENV["SCALINGO_TOKEN"])
scalingo.user.self
```

## Configuration

```ruby
Scalingo.configure do |config|
  # Known regions. Each region should have a corresponding entry in the urls settings below
  config.regions = %i[osc_fr1 osc_secnum_fr1]

  # Endpoints URLS
  config.urls do
    config.auth = "https://auth.scalingo.com/v1"
    config.osc_fr1 = "https://api.osc-fr1.scalingo.com/v1"
    config.osc_secnum_fr1 = "https://api.osc-secnum-fr1.scalingo.com/v1"
  end

  # Configure the User Agent header
  config.user_agent = "Scalingo Ruby Client v#{Scalingo::VERSION}"

  # For how long is a bearer token considered valid (it will raise passed this delay).
  # Set to nil to never raise.
  config.exchanged_token_validity = 1.hour

  # Raise an exception when trying to use an authenticated connection without a bearer token set
  # Having this setting to true prevents performing requests that would fail due to lack of authentication headers.
  config.raise_on_missing_authentication = true
end
```

### Examples

```ruby
require "scalingo"

scalingo = Scalingo::Client.new

scalingo.authenticate_with(access_token: "my_access_token")
# OR
scalingo.authenticate_with(bearer_token: "my_bearer_jwt")

# Return your profile
scalingo.self

# List your SSH Keys
scalingo.keys.all

# Show one SSH Key
scalingo.keys.show("my-key-id")

# List your apps on osc-fr1
scalingo.osc_fr1.apps.all
```
