# Scalingo-ruby-api

A ruby wrapper for the Scalingo API

## Installation

This gem is not yet deployed on rubygems.

Add this line to your application's Gemfile:

```ruby
gem 'scalingo-ruby-api', github: 'Aethelflaed/scalingo-ruby-api'
```

And then execute:

```
bundle
```

Or install it yourself as:

```
gem install slack-api
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

