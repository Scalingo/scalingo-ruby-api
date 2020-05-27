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

  # Default region
  config.defaul_region = :osc_fr1

  # Endpoints URLS
  config.urls.auth = "https://auth.scalingo.com/v1"
  config.urls.osc_fr1 = "https://api.osc-fr1.scalingo.com/v1"
  config.urls.osc_secnum_fr1 = "https://api.osc-secnum-fr1.scalingo.com/v1"

  # Configure the User Agent header
  config.user_agent = "Scalingo Ruby Client v#{Scalingo::VERSION}"

  # For how long is a bearer token considered valid (it will raise passed this delay).
  # Set to nil to never raise.
  config.exchanged_token_validity = 1.hour

  # Raise an exception when trying to use an authenticated connection without a bearer token set
  # Having this setting to true prevents performing requests that would fail due to lack of authentication headers.
  config.raise_on_missing_authentication = true

  # These headers will be added to every request. Individual methods may override them.
  # This should be a hash or a callable object that returns a hash.
  config.additional_headers = {}
end
```

:warning: If you change the settings for the list of regions, you **cannot** use `require "scalingo"`; you must follow this template :

```ruby

require "scalingo/config"

Scalingo.configure do |config|
  config.regions = %i[my-regions]
end

require "scalingo/client"
```

### Response object

Responses are parsed with the keys symbolized and then encapsulated in a `Scalingo::API::Response` object:
* `response.status` containts the HTTP status code
* `response.data` contains the "relevant" data, without the json root key (when relevant)
* `response.full_data` contains the full response body
* `response.meta` contains the meta object, if there's any
* `response.headers` containts all the response headers

Some helper methods are defined on thise object:
* `response.successful?` returns true when the code is 2XX
* `response.paginated?` returns true if the reponse has metadata relative to pagination
* `response.operation?` returns true if the response contains a header relative to an ongoing operation
* `response.operation` returns the URL to query to get the status of the operation

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
scalingo.keys.all # OR scalingo.auth.keys.all

# Show one SSH Key
scalingo.keys.show("my-key-id")

# List your apps on the default region
scalingo.apps.all # OR scalingo.region.apps.all

# List your apps on osc-fr1
scalingo.osc_fr1.apps.all
```
