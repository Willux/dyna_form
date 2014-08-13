# DynaForm

* Delegate all your forms to given models. 
* Create multiple entries through a single form without a need for nesting.

## Installation

Add this line to your application's Gemfile:

    gem 'dyna_form'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dyna_form

## Usage

If you are using Ruby on Rails, I suggest you create a `app/forms` folder. This way you can keep your form submission functionality separate from the rest of the code.

Create a class that extends `DynaForm::Base`:

```ruby
class TestForm < DynaForm::Base
  # TODO: Put code here
end
```

Now suppose `:first_name` and `:last_name` belong in the `User` model, while
`address` belongs in the `Address` model. You can create a form in the following
way:
```ruby
form_for @user do |f|
  f.input :first_name
  f.input :last_name
  f.fields_for :address do |a|
    a.input :address
```

This is just a simple example. The form can get much more complicated and more
nested. **It can get really ugly really fast**

Now suppose we have our `TestForm` like so:

```ruby
class TestForm < DynaForm::Base
  submit :first_name, :last_name, to: User
  submit :address, to: Address
end
```

In the controller you can create a form object to pass in to the view:

```ruby
@test_form = TestForm.new
```

Then in your view you can use the object and create any fields you want:
```ruby
form_for @test_form do |f|
  f.input :first_name
  f.input :last_name
  f.input :address
end
```

Once all the form values are passed, you can create the object with the params:
```ruby
@test_form = TestForm.new(params)
```

and submit it:

```ruby
@test_form.submit!
```

`DynaForm#submit!` calls `ActiveRecord::Base#create!`. Which means that whatever
exception `ActiveRecord::Base#create!` throws, `DynaForm#submit!` will throw.

You are welcome to add any validations you want in the form class. It'll allow you to keep your models skinnier and encapsulate any form functionality in a single class.

## Contributing

1. Fork it ( https://github.com/willux/dyna_form/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
