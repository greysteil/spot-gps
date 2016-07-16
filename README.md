# SPOT GPS

An API client library for SPOT's [API](http://faq.findmespot.com/index.php?action=showEntry&data=69).

[![Gem Version](https://badge.fury.io/rb/spot-gps.svg)](http://badge.fury.io/rb/spot-gps)
[![Build Status](https://travis-ci.org/greysteil/spot-gps.svg?branch=master)](https://travis-ci.org/greysteil/spot-gps)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spot-gps'
```

You'll then need to require SPOT before using it:

```ruby
require 'spot'
```

## Configuration

Timeout options can be configured globally, or you can rely on the default
values below:

```ruby
SPOT.configure do |config|
  config.open_timeout = 30
  config.read_timeout = 80
end
```

## Usage

API calls are made using an instance of the `SPOT::Client` class:

```ruby
api = SPOT::Client.new(feed_id: 'FEED_GIID', feed_password: 'OPTIONAL_PASSWORD')
```

### Resources

Currently, the SPOT API only supports the `messages` resource.

#### Messages

Messages are communications sent from a SPOT device.

```ruby
api.messages.all     # => Returns a lazily paginated list of messages for a feed
api.messages.list    # => Returns a list of messages for a given page of a feed
api.messages.latest  # => Returns the most recent message for a feed
```

Each message has the following details available:

```ruby
message = api.messages.latest

message.id                    # => Integer. ID of the SPOT message
message.created_at            # => Time
message.type                  # => String. Message type (e.g., "OK", or "HELP")
message.latitude              # => Float
message.longitude             # => Float
message.battery_state         # => String. Battery state at time of sending (e.g., "GOOD")
message.hidden                # => Boolean. I'm not sure what this is for...
message.show_custom_message   # => Boolean. I'm not sure what this is for...
message.content               # => String
message.messenger_id          # => String. As used when registering your SPOT
message.messenger_name        # => String. As specified when registering your SPOT
message.messenger_model       # => String. E.g., "SPOT3"
```

You can also call `#to_h` on a message to get its (cleaned) attributes as a
hash, or `#to_raw_h` to get the attributes as returned by SPOT.

### Pagination

If you want to get all of the records for a given resource type, you can use the
`#all` method to get a lazily paginated list. `#all` will deal with making extra
API requests to paginate through all the data for you:

```ruby
api.messages.all.each { |message| puts message.created_at }
```

Alternatively, you can use the `#list` method to get a specific page of entries.
By default, the first page of 50 records are fetched. To fetch subsequent pages
(each of 50 records), specify a `page`.

```ruby
api.messages.list(page: 2)
```

### Filtering

The SPOT API only supports filtering by date. You can do so using either the
`#list` or `#all` methods.

```ruby
api.messages.all(start_at: '2014-06-01T00:00:00', end_at: '2015-06-01T00:00:00')
api.messages.list(start_at: '2014-06-01T00:00:00', end_at: '2015-06-01T00:00:00')
```

You can pass the `start_at` and `end_at` parameters as a `String`, `Time`,
`DateTime` or `Date`, and the gem will handle formatting it correctly for SPOT.

### Raw responses

If you'd like to query the un-wrapped response data from SPOT, you can use the
`#response` method to do so.

```ruby
message = api.messages.latest
response = message.response

response.body         # => Hash. JSON body
response.headers      # => Hash. Headers returned by SPOT
response.status       # => Integer. Status code returned by SPOT
```

### Error Handling

TODO: Currently the gem will just raise Faraday errors if anything goes wrong
with a request.


## Contributing

1. Fork it ( https://github.com/greysteil/spot-gps/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
