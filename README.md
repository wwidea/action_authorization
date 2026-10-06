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

By default, an unauthorized action raises `ActionAuthorization::AuthorizationFailure`.
Applications can handle it in their base controller and choose an appropriate response:

```ruby
class ApplicationController < ActionController::Base
  rescue_from ActionAuthorization::AuthorizationFailure, with: :authorization_failure

  private

  def authorization_failure
    head :forbidden
  end
end
```

### `policy`

Check if authorized before displaying a link in the view.

```erb
<%= link_to(@document.name, @document) if policy(@document).show? %>
```

### `policy_for`

An enhanced version of `policy` that also accepts a `[parent, model]` pair for authorizing a new
nested record.

```ruby
policy_for([folder, Document])
```

This creates the model with the parent assigned to its association and returns its policy. Unlike
`folder.documents.build`, it does not add the new record to the parent's cached association.

When passed a single object, `policy_for` behaves the same as `policy`:

```ruby
policy_for(document)
```

## Testing support

Testing helpers are opt-in and are loaded separately from the runtime API:

```ruby
require "action_authorization/testing"
```

The shared `PolicyHelpers` module provides `allow` and `forbid`. It requires including modules to
define `policy_class_default`, so include the specialized module for the test type rather than
including `PolicyHelpers` directly:

```ruby
class ActionDispatch::IntegrationTest
  include ActionAuthorization::Testing::IntegrationTestPolicyHelpers
end

class ActionView::TestCase
  include ActionAuthorization::Testing::ViewTestPolicyHelpers
end
```

`IntegrationTestPolicyHelpers` derives the policy class from the test class name (for example,
`DocumentsControllerTest` uses `DocumentPolicy`). `ViewTestPolicyHelpers` defaults to `OpenPolicy`
and includes `PolicyStub`, so `policy` returns an open policy in view tests. Both modules provide
`allow` and `forbid`.

If needed, `PolicyStub` can also be included separately in another test class to make `policy`
return an open policy:

```ruby
class SomeHelperTest < ActiveSupport::TestCase
  include ActionAuthorization::Testing::PolicyStub
end
```

`OpenPolicy` allows every action by default, including non-standard predicates such as
`activate?`. Use `forbid(:activate)` to override a specific action.

The expectation helpers use the `any_instance.expects` API and require Mocha to be configured by
the client application's test suite.

### Examples

In an integration test, `allow` and `forbid` set the result of the action predicate on the policy
class inferred from the test class name. For `DocumentsControllerTest`, that is `DocumentPolicy`:

```ruby
class DocumentsControllerTest < ActionDispatch::IntegrationTest
  test "shows an authorized document" do
    allow(:show)

    get document_url(documents(:one))
    assert_response :success
  end

  test "raises when showing a forbidden document" do
    forbid(:show)

    assert_raises(ActionAuthorization::AuthorizationFailure) do
      get document_url(documents(:one))
    end
  end
end
```

In a view test, `ViewTestPolicyHelpers` uses `OpenPolicy`, so the link is allowed by default. Use
`forbid(:show)` to exercise the hidden-link case:

```ruby
class DocumentsHelperTest < ActionView::TestCase
  test "returns a link to an authorized document" do
    assert link_to_document(documents(:one))
  end

  test "returns nil when showing the document is forbidden" do
    forbid(:show)

    assert_nil link_to_document(documents(:one))
  end
end
```

Helpers that render a template or partial that calls `policy` need the view object stubbed too.
Call `view_policy_stub` in those tests:

```ruby
test "returns the document header" do
  view_policy_stub

  assert_includes document_header(documents(:one)), "Document"
end
```

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
