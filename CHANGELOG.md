## v0.2.8, 7 October 2019

- Support faraday 0.17.0

## v0.2.7, 20 April 2018

- Support faraday 0.15.0

## v0.2.6, 15 August 2017

- Support faraday 0.13.0

## v0.2.5, 22 June 2017

- Update gemspec metadata links

## v0.2.4, 22 June 2017

- Clean up gemspec

## v0.2.3, 31 July 2016

- Handle missing `messageContent` field (not present on TRACK messages)

## v0.2.2, 17 July 2016

- Don't include password in querystring when it's blank
- Handle "no-messages" response when asking for latest message

## v0.2.1, 16 July 2016

- Add support for Ruby 2.2 and 2.1.

## v0.2.0, 11 July 2016

- `#to_h` now returns a resources cleaned attributes, not its initial input
- Add `#to_raw_h` method to SPOT::Resources::Message, which replaces `#to_h`
- Make `#response` available on ListResponse, and document it

## v0.1.0, 10 July 2016

- Move old `all` functionality to `list`
- Introduce new `all` method, that lazily paginates through all resources

## v0.0.2, 10 July 2016

- Wrap responses in SPOT::Resources::Message objects, making them easier to work
  with (allows date/time parsing, etc.).
- Drop support for all Ruby versions prior to 2.3 (would be easy to
  re-introduce, but I imagine anyone using this gem is building a new app).
- Rename Spot::API to Spot::Client
- Remove logger configuation, and move to Faraday

## v0.0.1, 10 July 2016

- Initial release
