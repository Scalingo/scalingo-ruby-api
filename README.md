# Scalingo-ruby-api

A ruby wrapper for the Scalingo API

## Installation

```ruby
gem 'scalingo-ruby-api', '~> 2'
```

And then execute:

```
bundle
```

Or install it yourself as:

```
gem install scalingo-ruby-api
```

## Usage

### Global configuration

```ruby
require 'scalingo'

Scalingo.token = 'tk-your-token'
Scalingo.region = 'osc-fr1'

# Or

Scalingo.configure do |config|
  config.token = 'tk-your-token'
  config.region = 'osc-fr1'
end

client = Scalingo::Client.new
```

### Client configuration

```ruby
client = Scalingo::Client.new(region: 'osc-fr1', token: 'tk-your-token')

# Or both can be combined

Scalingo.token = 'tk-your-token'

client_region1 = Scalingo::Client.new(region: 'osc-fr1')
client_region2 = Scalingo::Client.new(region: 'agora-fr1')
```

### Examples

```ruby
# Get all apps
apps = client.apps.all

# Get logs of one app
app = client.apps.find('my-app')
puts app.logs.dump
```

### Notes

Client contains a cache with the regions endpoints and the current valid bearer
token used for authentication.

If a lot of calls are done and to avoid making useless requests and slowing
down your queries, it is encouraged to re-use your client.

## Hacking

Using another authentication endpoint for hacking is possible through

```
client = Scalingo::Client.new(auth_endpoint: 'http://172.17.0.1:1234/v1', region: 'local')
apps = client.apps.all
```

## Special Thanks

To aki017 who made [slack-ruby-gem](http://github.com/aki017/slack-ruby-gem).

It was used as an inspirational source for this project.

Thanks [Aethelflaed](https://github.com/Aethelflaed) for the original implementation of this gem
