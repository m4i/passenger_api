# PassengerAPI

PassengerAPI is a Rack application to access Passenger internal APIs.

[![Gem Version](https://badge.fury.io/rb/passenger_api.svg)](https://badge.fury.io/rb/passenger_api)
[![Build Status](https://travis-ci.org/m4i/passenger_api.svg?branch=master)](https://travis-ci.org/m4i/passenger_api)
[![Test Coverage](https://codeclimate.com/github/m4i/passenger_api/badges/coverage.svg)](https://codeclimate.com/github/m4i/passenger_api/coverage)
[![Code Climate](https://codeclimate.com/github/m4i/passenger_api/badges/gpa.svg)](https://codeclimate.com/github/m4i/passenger_api)

## Usage

Run PassengerAPI:

```
gem install passenger_api
passenger_api
```

or

```
docker run --rm -v /tmp:/tmp -p 3000:3000 m4i0/passenger_api
```

Run your application:

```
passenger start -p 3001
```

Then, access API.

```
$ curl -s localhost:3000/ping.json | jq .
[
  {
    "instance": {
      "instance_dir": {
        "created_at": 1527877456,
        "created_at_monotonic_usec": 8184689115911,
        "major_version": 4,
        "minor_version": 0,
        "path": "/tmp/passenger.VWzMe1k"
      },
      "instance_id": "p9npsg-ojQFlj-pTG7Y9",
      "integration_mode": "standalone",
      "name": "XELqenPb",
      "passenger_version": "5.3.1",
      "server_software": "nginx/1.14.0 Phusion_Passenger/5.3.1",
      "standalone_engine": "nginx",
      "watchdog_pid": 186,
      "core_pid": 189,
      "state": "good"
    },
    "status": 200,
    "header": {
      "Status": "200 OK",
      "Content-Type": "application/json",
      "Date": "Fri, 01 Jun 2018 18:29:08 +0000",
      "Connection": "keep-alive",
      "Content-Length": "18"
    },
    "body": "{ \"status\": \"ok\" }"
  }
]

$ curl -s localhost:3000/pool.txt | jq '.[].body' -r
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

$ curl -s localhost:3000/pool.xml | jq '.[].body' -r | xmllint --format -
<?xml version="1.0" encoding="iso8859-1"?>
<info version="3">
  <passenger_version>5.3.1</passenger_version>
  <group_count>1</group_count>
  <process_count>1</process_count>
  <max>6</max>
  <capacity_used>1</capacity_used>
  <get_wait_list_size>0</get_wait_list_size>
  <supergroups>
(snip)
  </supergroups>
</info>
```

Multiple instances:

```
$ docker run -d --rm -v /tmp/a:/tmp/a phusion/passenger-ruby25 passenger start --instance-registry-dir /tmp/a
$ docker run -d --rm -v /tmp/b:/tmp/b phusion/passenger-ruby25 passenger start --instance-registry-dir /tmp/b
$ docker run -d --rm -v /tmp/c:/tmp/c phusion/passenger-ruby25 passenger start --instance-registry-dir /tmp/c
$ curl -sH 'X-Passenger-Instance-Registry-Dir: /tmp/*' localhost:3000/ping.json | jq .
[
  {
(snip)
        "path": "/tmp/b/passenger.1kGFpF5"
(snip)
  },
  {
(snip)
        "path": "/tmp/a/passenger.P5HNi8e"
(snip)
  },
  {
(snip)
        "path": "/tmp/c/passenger.6oU9Cgi"
(snip)
  }
]
```

Passenger internal APIs are undocumented. If you want to know about them, please see https://github.com/phusion/passenger/issues/1407.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/m4i/passenger_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PassengerAPI project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/m4i/passenger_api/blob/master/CODE_OF_CONDUCT.md).
