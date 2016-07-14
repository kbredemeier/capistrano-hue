# Capistrano::Hue

Capistrano tasks for using Philips Hue lights as a deployment indicator. In the current state, it is basically just
turning the specified light bulp on and off during deployment.

## Installation

Add this to your Gemfile:

```ruby
group :development do
  gem 'capistrano' '~> 3.1'
  gem 'capistrano-hue' '~> 0.1'
end
```

And then execute:

    $ bundle install


## Usage

Add this line to your `Capfile`

    require 'capistrano/hue'

## Configuration

```
# config/deploy/production.rb

set :hue_enabled, true
set :hue_bridge_ip, '10.100.198.4'
set :hue_user_id, '871baa6b48b3a42af620f2509a1f'
set :hue_light_bulp_id, 1
set :hue_process_name, 'capistrano-hue'
```

You can test your configuration by running `cap <env> hue:start` to start the sequence and `cap <env> hue:stop` to stop the sequence.

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/capistrano-hue. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

