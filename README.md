# GroupMe Ruby Gem (BETA)
[![Build Status](https://travis-ci.org/kinnell/groupme-ruby-gem.svg?branch=master)](https://travis-ci.org/kinnell/groupme-ruby-gem)
[![Coverage Status](https://coveralls.io/repos/github/kinnell/groupme-ruby-gem/badge.svg?branch=master)](https://coveralls.io/github/kinnell/groupme-ruby-gem?branch=master)
[![Known Vulnerabilities](https://snyk.io/test/github/kinnell/groupme-ruby-gem/badge.svg?targetFile=Gemfile.lock)](https://snyk.io/test/github/kinnell/groupme-ruby-gem?targetFile=Gemfile.lock)

A Ruby wrapper for [GroupMe REST API (v3)](https://dev.groupme.com/docs/v3).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'groupme-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install groupme-api

## Configuration

Get a developer access token at: https://dev.groupme.com/

```ruby
require 'groupme'

client = GroupMe::Client.new(
  access_token: 'ax7snqkoRiJ0yGPsbKSgeBnBEtqeSkALMC2qJPrT'
)
```

## Usage

#### Get All Groups

```ruby
response, status = client.get('groups')
puts response
```

#### Create A Group

```ruby
response, status = client.post('groups', name: 'New Group')
puts response
```

## Deployment
1. Update `lib/groupme/version.rb` & run `bundle update`
2. Commit files ("Bump version to <VERSION>")
3. Run `rake build`
4. Run `rake release`
5. Run `gem push pkg/groupme-api-<VERSION>.gem` and enter MFA OTP code
6. Run `gem push --key github --host https://rubygems.pkg.github.com/kinnell pkg/groupme-api-<VERSION>.gem` for GitHub Packages
