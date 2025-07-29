# Scalingo

A ruby wrapper for the Scalingo API

## Installation

```ruby
gem "scalingo"
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
scalingo.self
```

## Conventions

Most methods map to one (and only one) request, and their signature follows this format:

```ruby
client.section.request(app_id:, id:, body:)
```

* Depending on the request, there may be no id (collection and/or singular resource, such as `user`), one, or two ids (many resources are nested under an app).
* Most of the time, this library won't do any processing of the payload, but there's a few things to know:
  * the root key doesn't need to be specified, the library handles it
  * in some cases, the payload isn't passed as supplied (`metrics`, for instance, extracts the parts that are meant to be used as url fragments)

## Configuration

You can refer to the code below to configure the gem globally.
The values displayed match the default ones.

:warning: Configuration is copied when instanciating a `Scalingo::Client` object;
changing the configuration globally will therefore not affect already existing objects.

```ruby
Scalingo.configure do |config|
  # Default region. Must be a supported region (osc_fr1, osc_secnum_fr1)
  config.default_region = :osc_fr1

  # Configure the User Agent header
  config.user_agent = "Scalingo Ruby Client v#{Scalingo::VERSION}"

  # These headers will be added to every request
  # This should be a hash or a callable object that returns a hash.
  config.additional_headers = {}

  # Specify an adapter for faraday. Leave nil for the default one (Net::HTTP)
  config.faraday_adapter = nil
end
```

You can also configure each client separately.
Values not supplied will be copied from the global configuration.

```ruby
scalingo = Scalingo::Client.new(user_agent: "A new kind of agent")
```

## Other details on the code architecture

* `Scalingo::Client` instances hold configuration and the token used for authentication
* `Scalingo::API::Client` subclasses (`Scalingo::Auth`, `Scalingo::Billing`, `Scalingo::Regional`) provides access to the APIs.
You can use `connection` (returns a faraday instance) on those objects to perform any request freely.
* `Scalingo::API::Endpoint` subclasses (`Scalingo::Auth::User`) instances belong to an api client (cf previous point).
They provide quick and uniform access to expected requests.

## Examples

```ruby
require "scalingo"

scalingo = Scalingo::Client.new

scalingo.authenticate_with(access_token: "my_access_token")
# OR
scalingo.authenticate_with(bearer_token: "my_bearer_jwt")

# Return your profile
scalingo.self # or scalingo.auth.user.find

# List your SSH Keys
scalingo.keys.all # OR scalingo.auth.keys.all

# Show one SSH Key
scalingo.keys.show(id: "my-key-id")

# List your apps on the default region
scalingo.apps.all # OR scalingo.region.apps.all

# List your apps on osc-fr1
scalingo.osc_fr1.apps.all # OR scalingo.region(:osc_fr1).apps.all

# Preview the creation of an app on the default region
scalingo.apps.create(name: "my-new-app", dry_run: true)
```

### Interacting with databases

Requests to the [database API](https://developers.scalingo.com/databases/) requires
extra authentication for each addon you want to interact with. [Addon authentication
tokens are valid for one hour](https://developers.scalingo.com/addons#get-addon-token).

```ruby
require "scalingo"

scalingo = Scalingo::Client.new
scalingo.authenticate_with(access_token: "my_access_token")

# First, authenticate using the `addons` API
dbclient = scalingo.osc_fr1.addons.database_client_for(app_id:, id:)

# Once authenticated for that specific addon, you can interact with
# database and backup APIs.
# IDs of databases are the IDs of the corresponding addons

# get all information for a given database
dbclient.databases.find(id:)

# get all backups for a given database
dbclient.backups.list(addon_id:)

# get URL to download backup archive
dbclient.backups.archive(addon_id:, id:)

```

## Development

### Install

```bash
bundle
```

### Run tests

```bash
bundle exec rspec
```

## Deploy a new version

In order to deploy a new version, you first need to tag that version. For that, two files need to be updated:
- The CHANGELOG, to include the list of the changes you are releasing
- `lib/scalingo/version.rb` with the version number

Once the PR is merged, you need to tag the version. EG:

```bash
git checkout master
git pull
git tag v4.0.beta3
git push origin master --tags
```

When the tags are pushed, you need to go [here](https://github.com/Scalingo/scalingo-ruby-api/releases) and create a new
release with the new tag. Once this is done, a GitHub Action will take care of publishing the new version.