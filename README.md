# SPOT GPS

A thin wrapper for SPOT's [API](http://faq.findmespot.com/index.php?action=showEntry&data=69).

[![Gem Version](https://badge.fury.io/rb/spot-gps.svg)](http://badge.fury.io/rb/spot-gps)
[![Build Status](https://travis-ci.org/greysteil/spot-gps.svg?branch=master)](https://travis-ci.org/greysteil/spot-gps)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spot-gps'
```

## Configuration

There are 3 configuration options:

```ruby
SPOT.configure do |config|
  config.logger = Logger.new(STDOUT)
  config.open_timeout = 30
  config.read_timeout = 80
end
```

## Usage

API calls are made using an instance of the `API` class:

```ruby
api = SPOT::API.new(feed_id: 'FEED_GIID', feed_password: 'OPTIONAL_PASSWORD')
```

### Resources

Currently, the SPOT API only supports a single `messages` resource.

#### Messages

Messages are communications sent from a SPOT device.

```ruby
api.messages.all     # => Returns a (paginated) list of all messages for a feed
api.messages.latest  # => Returns the most recent message for a feed
```

### Pagination

All resources that support an `all` method also support pagination. By default,
the first page of 50 records are fetched. To fetch subsequent pages (each of 50
records), specify a `page`.

```ruby
api.messages.all(page: 2)
```

### Filtering

The SPOT API supports filtering by date.

```ruby
api.messages.all(start_at: '2014-06-01T00:00:00', end_at: '2015-06-01T00:00:00')
```

### Error Handling

TODO: Currently the gem will just raise RestClient errors.

## Contributing

1. Fork it ( https://github.com/greysteil/spot-gps/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
