# TryApi

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/try_api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'try_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install try_api

## Usage

1. First you need to install gem with dependencies

    - rails g try_api:install

2. Mount try_api engine to your routes. Add this to routes.rb

    - mount TryApi::Engine => '/developers'

3. Modify config/try_api.yml generaded after install command

    - project_name: 'Air Stylist'
      categories:
        -
          title: 'Introduction'
          menu_items:
            -
              title: 'Introduction'
              description: "Lorem ipsum."
            -
              title: 'What does that mean for you, the Stylist?'
              description: "Lorem ipsum."
            -
              title: 'What does that mean for you the Client? '
              description: "Lorem ipsum."

        -
          title: 'Sessions'
          menu_items:
            -
              title: 'Sessions'
              html: '<p>
                       This is an object representing your Stripe balance. You can retrieve it to see the balance currently on your Stripe account.
                     </p>
                     <p>
                       You can also retrieve a list of the balance history, which contains a list of transactions that contributed to the balance (e.g.,
                       charges, transfers, and so forth).
                     </p>
                     <p>
                       The available and pending amounts for each currency are broken down further by payment source types.
                     </p>'
              second_level_menu_items:
                -
                  title: 'Login'
                  parameters:
                    -
                      name: 'email'
                      type: 'string'
                    -
                      name: 'last_name'
                      type: 'string'
                    -
                      name: 'email'
                      type: 'boolean'
                  headers:
                    -
                      name: 'first_name'
                      type: 'string'

                -
                  title: 'Logout'
                  parameters:
                    -
                      name: 'email'
                      type: 'string'
                    -
                      name: 'last_name'
                      type: 'string'
                    -
                      name: 'email'
                      type: 'boolean'
                  headers:
                    -
                      name: 'first_name'
                      type: 'string'


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/try_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

