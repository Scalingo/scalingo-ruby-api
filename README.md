# Scalingo-ruby-api

A ruby wrapper for the Scalingo API

## Installation

```ruby
gem 'scalingo-ruby-api', '1.0.0.alpha1'
```

And then execute:

```
bundle
```

Or install it yourself as:

```
gem install scalingo-ruby-api --prerelease
```

## Usage

```ruby
require 'scalingo'

Scalingo.token = "YOUR TOKEN"
# Or

Scalingo.configure do |config|
  config.token = "YOUR TOKEN"
end

Scalingo.apps.all
Scalingo.apps.first.logs.dump
```

## Todo

Before any release:

* Test ! I wrote most of this in a few hours rush, but more as a proof of concept than a gem.
Most of the code *should probably* work, but we're never sure.

## Special Thanks

To aki017 who made [slack-ruby-gem](http://github.com/aki017/slack-ruby-gem).

I used most of this project source code and mostly changed only the endpoints.

Thanks to [scalingo](http://scalingo.io) for their awesome product and API ^.^
Thanks [Soulou](https://github.com/Soulou) for his support implementing this gem.

