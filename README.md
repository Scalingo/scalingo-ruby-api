# Scalingo

A ruby wrapper for the Scalingo API

### Migration from v2

This gem is changing its name from `scalingo-ruby-api` to `scalingo`,
and the versionning does **not** reset; the first major version of `scalingo`
will therefore be `3.x.x`.

You can check the version 2 at [the v2 branch of this repository](https://github.com/Scalingo/scalingo-ruby-api/tree/v2)

### The road to 3.0.0

This gem is still in beta version, but its API should not change a lot until a final release.
However, configuration may change. An issue will be opened and pinned to follow up the work that remains to be done.

## Installation

```ruby
gem "scalingo", "3.0.0.beta.1"
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

## Conventions

Most methods map to one (and only one) request, and their signature follows this format:

```ruby
client.section.request(id, payload = {}, headers = nil, &block)
```

* Depending on the request, there may be no id (collection and/or singular resource, such as `user`), one, or two ids (many resources are nested under an app).
* Most of the time, this library won't do any processing of the payload, but there's a few things to know:
  * the root key shouldn't be specified, the library handles it
  * in some cases, the payload isn't passed as supplied (`metrics`, for instance, extracts the parts that are meant to be used as url fragments)
* headers can be supplied on a per-request basis, using either the last argument or the block version:
  * when using the last argument, you may have to pass an empty hash payload (`{}`)
  * when using the block form, the faraday object is supplied as argument, and you can do any kind of treatment you would like

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

  # Raise an exception when the bearer token in use is supposed to be invalid
  config.raise_on_expired_token = false
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

## Response object

Responses are parsed with the keys symbolized and then encapsulated in a `Scalingo::API::Response` object:
* `response.status` containts the HTTP status code
* `response.data` contains the "relevant" data, without the json root key (when relevant)
* `response.full_data` contains the full response body
* `response.meta` contains the meta object, if there's any
* `response.headers` containts all the response headers

Some helper methods are defined on this object:
* `response.successful?` returns true when the code is 2XX
* `response.paginated?` returns true if the reponse has metadata relative to pagination
* `response.operation?` returns true if the response contains a header relative to an ongoing operation
* `response.operation` returns the URL to query to get the status of the operation

## Examples

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

# Preview the creation of an app on the default region
scalingo.apps.create(name: "my-new-app", dry_run: true)
```
