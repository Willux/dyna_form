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

* If you are using Ruby on Rails, I suggest you create a `app/forms` folder.
  This way you can keep your form submission functionality separate from the
  rest of the code.
* Create a class that extends `DynaForm::Base`:
  ```Ruby
  class TestClass < DynaForm::Base
    # TODO: Put code here
  end
  ```

## Contributing

1. Fork it ( https://github.com/willux/dyna_form/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
