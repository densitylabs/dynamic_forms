# DynamicForms
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'dynamic_forms'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install dynamic_forms
```

Then, add the migrations:
```
rake dynamic_forms:install:migrations
rake db:migrate
```

# mount forms

You can mount the UI using:

```
mount DynamicForms::Engine, at: '/dynamic_forms'
```

then you can add to your rails app the following link:

```
link_to 'dynamic_forms', dynamic_forms.custom_forms_path
```


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
