# PassengerAPI

PassengerAPI is a Rack application to access Passenger internal APIs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'passenger_api'
```

## Usage

Add this line to your application's config.ru:

```ruby
map('/passenger') { run PassengerAPI.new }
```

Then, access API.

```
$ passenger start -d
$ curl localhost:3000/passenger/pool.txt
----------- General information -----------
Max pool size : 6
App groups    : 1
Processes     : 1
Requests in top-level queue : 0

----------- Application groups -----------
/app/public (development):
  App root: /app
  Requests in queue: 0
  * PID: 25915   Sessions: 1       Processed: 3       Uptime: 30s
    CPU: 0%      Memory  : 7M      Last used: 0s ago
```

Passenger internal APIs are undocumented. If you want to know about them, please see https://github.com/phusion/passenger/issues/1407.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/m4i/passenger_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PassengerAPI project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/m4i/passenger_api/blob/master/CODE_OF_CONDUCT.md).
