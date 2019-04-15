# ActionAuthorization

A base policy class for authorizing controller actions with access to the current_user and object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'action_authorization'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install action_authorization

## Requirements

ActionAuthorization requires a **current_user** method that returns the currently logged in user.

## Usage

Include the ActionAuthorization module in your ApplicationController (or indvidual controller(s))

```ruby
class ApplicationController < ActionController::Base
  include ActionAuthorization
end
```

Create an authorization policy for a resource.

``` ruby
class DocumentPolicy < ActionAuthorization::BasePolicy
  def show?
    document.owner == user
  end
end
```

Call **authorize** method in controller action.

```ruby
class DocumentController < ApplicationController
  def show
    @document = authorize(Document.find(params[:id]))
  end
end
```

Pass a **policy_class** to authorize to override the default resource based policy.
```ruby
class DocumentController < ApplicationController
  def show
    @document = authorize(Document.find(params[:id]), policy_class: UserOwnerPolicy)
  end
end
```

Check if authorized before displaying a link in the view.

```erb
<%= link_to(@document.name, @document) if policy(@document).show? %>
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wwidea/action_authorization.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
