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

### Global configuration

_TBD_

### Client configuration

_TBD_

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
