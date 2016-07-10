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
