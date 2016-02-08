# SimpleBlacklist
___

This project is designed to make easy the task of sanitizing string that contains words not allowed.

## Installation
___

Add this line to your application's Gemfile:

```ruby
gem 'simple_blacklist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_blacklist

## Setup (Rails)
___

    $ simple_blacklist --configure

Will be created:

 * *config/initializers/simple_blacklist.rb*
 * *config/blacklist.yml*

## Usage
___

In your code, do:

```ruby
offensive_text = "Kiss my ass"
SimpleBlacklist.sanitize(offensive_text)

# "Kiss my xxxxx"
```

If configured *letters_variations* is also possible to sanitize texts written with special characters
```ruby
offensive_text = "Kiss my @$$"
SimpleBlacklist.sanitize(offensive_text)

# "Kiss my xxxxx"
```

## Development
___

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simple_blacklist. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License
___

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

