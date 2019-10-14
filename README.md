# DynamicForms
This is a gem to create custom forms.
The custom form is a logical entity that allows adding a lot of submissions with any parameter and they can be stored in a database and/or sent to some emails

This gem support **Rails 5** and later

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'dynamic_forms'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install dynamic_forms
```

After then you need to create migrations, to do this run
```bash
$ rails dynamic_forms:install:migrations
```
To add the custom_form routes you need to add the next line into your routes file

```ruby
mount DynamicForms::Engine => "/dynamic_forms"
```
You can change the path name from `dynamic_forms` to your awesome name what you want to use.

## Usage

Use this gem is very simple, you only need to create a new form with a name.
![custom forms](https://user-images.githubusercontent.com/6145762/66779321-6eeade00-ee93-11e9-96dd-63d31db962f8.png)

To config the form you need to go to the edit/settings page

![edit page](https://user-images.githubusercontent.com/6145762/66771905-16aae080-ee81-11e9-9754-7bb5a9c58a64.png)

On this page, we see the endpoint where you can send new submissions.

Also, you can:
- Add target email to send the submission
- Enable/Disable the form
- Enable/Disable email notifications to target email
- Enable/Disable the option to record data on the DB
- Restrict the request to a specific domain (and subdomains)

Here an example of how the submissions page looks
![Submissions page](https://user-images.githubusercontent.com/6145762/66778863-7cec2f00-ee92-11e9-851a-d888465a2b85.png)

In this case, we create a table with those headers, but you can overwrite the views to change the table.

## How it works
the gem gives you a public endpoint for each form that you create, you can consume this endpoint of different ways.

You can use this a simple form with HTML or create  a complex with some JS Technology

Here an HTML example

```
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
  </head>
  <body>
    <form action="http://localhost:3000/dynamic_forms/form/6b697e963c644230681ea327" method="post">
      <div>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="">
      </div>
      <div>
        <label for="company">Company</label>
        <input type="text" name="company" id="company" value="">
      </div>
      <div>
        <label for="message">Message</label>
        <input type="text" name="message" id="message" value="">
      </div>
      <input type="hidden" name="_trap" value="">
      <div class="">
        <button type="submit">Send</button>
      </div>
    </form>
  </body>
</html>
```

Note: you can add a simple honeypot to avoid span for bots
`<input type="hidden" name="_trap" value="">`

## Contributing
1. Fork it
2. Create your feature branch (git checkout -b [feature | hotfix]/[issue-number]--- my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

Check our [issue list](https://github.com/densitylabs/dynamic_forms/issues) to contribute with us.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
