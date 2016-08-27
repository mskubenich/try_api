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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/try_api. 

1. Fork it
2. Create your feature branch 
    
    
    $ git checkout -b my-new-feature

3. Commit your changes


    $ git commit -am 'Add some feature'

4. Push to the branch 


    $ git push origin my-new-feature

5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

