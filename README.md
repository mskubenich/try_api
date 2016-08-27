# TryApi

Simple live API documentation for Rails applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'try_api'
```

And then execute:

    $ bundle
    
This will generates config file example:

    $ rails generate try_api:install
    
Mount try_api engine to your routes. Add this to routes.rb

```ruby
mount TryApi::Engine => '/developers'
```

This works ony with Rails yet. Maybe there is a reason to make it self-sufficient ? Using sinatra for example...

## Usage

3. Modify config/try_api.yml

```yml
    - project_name: 'Air Stylist'
      categories:
        -
          title: 'Introduction'
          menu_items:
           
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/try_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

