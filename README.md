# TryApi

Simple live API documentation for Rails applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'try_api'
```

And then execute:

    $ bundle
    
This will generate config file example:

    $ rails generate try_api:install
    
Mount try_api engine to your routes. Add this to routes.rb

```ruby
mount TryApi::Engine => '/developers'
```

This works ony with Rails yet. Maybe there is a reason to make it self-sufficient ? Using sinatra for example...

## Usage

3. Modify config/try_api.yml

```yml
    project_name: 'My awesome project'
    host: 'http://localhost'
    port: 3000
    api_prefix: 'api/v1'
    menu_items:
      -
        title: 'Introduction'
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
      -
        title: 'Sessions'
        methods:
          -
            title: 'Login'
            description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
            path: '/login'
            method: 'post'
            parameters:
              -
                name: 'email'
                type: 'string'
              -
                name: 'password'
                type: 'string'
                description: 'user password'
            example_responses:
              -
                code: 200
                response: >
                  {
                    "session_token": "86c07402ac0be5e1be29ef194b11da6ecbb86d2b8debddfe462d71063d071fdd"
                  }
                type: 'json'
              -
                code: 422
                response: >
                  {
                    "errors": [
                      "Wrong login/password combination."
                    ]
                  }
                type: 'json'
           
```

## Contributing

Bug reports and pull requests are welcome:

1. Fork it
2. Create your feature branch(git checkout -b my-new-feature)
3. Commit your changes(git commit -am 'Add some feature')
4. Push to the branch(git push origin my-new-feature)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

