# ActionAuthorization

A base policy class for authorizing controller actions with access to the current_user and object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'action_authorization'
```

And then execute:

```bash
bundle
```

Or install it with:

```bash
gem install action_authorization
```

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

```ruby
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

### `policy`

Check if authorized before displaying a link in the view.

```erb
<%= link_to(@document.name, @document) if policy(@document).show? %>
```

### `policy_for`

An enhanced version of `policy` that also accepts a `[parent, model]` pair for authorizing a new nested record.

```ruby
policy_for([folder, Document])
```

This creates the model with the parent assigned to its association and returns its policy. Unlike `@family.enrollments.build`, it does not add the new record to the parent's cached association.

When passed a single object, `policy_for` behaves the same as `policy`:

```ruby
policy_for(document)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
