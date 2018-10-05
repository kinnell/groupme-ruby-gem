# GroupMe Ruby Gem
[![Build Status](https://travis-ci.org/kinnell/groupme-ruby-gem.svg?branch=master)](https://travis-ci.org/kinnell/groupme-ruby-gem)
[![Coverage Status](https://coveralls.io/repos/github/kinnell/groupme-ruby-gem/badge.svg?branch=master)](https://coveralls.io/github/kinnell/groupme-ruby-gem?branch=master)

A Ruby wrapper for [GroupMe REST API (v3)](https://dev.groupme.com/docs/v3).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'groupme'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install groupme

## Configuration

Get a developer access token at https://dev.groupme.com/.

```ruby
GroupMe.configure do |config|
    config.access_token = 'ax7snqkoRiJ0yGPsbKSgeBnBEtqeSkALMC2qJPrT'
end
```

## Usage
