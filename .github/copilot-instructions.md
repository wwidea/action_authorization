# Copilot instructions

## Build, test, and lint

- Install dependencies with `bundle install`.
- Run the test suite with `bin/test`.
- Run one test file with `bin/test test/lib/action_authorization_test.rb` (or replace the path with the test file you want).
- Run RuboCop with `bin/rubocop -f github`, matching the CI workflow.
- The project targets the Ruby version in `.ruby-version`; the gemspec supports Ruby 3.3 and newer.

## Architecture

`ActionAuthorization` is a controller mixin. Including it registers `policy` as a view helper; `policy` builds a policy with `current_user` and the object. For non-nil objects, the default policy class is derived from `object.model_name` plus `Policy`; nil objects use `NullPolicy`. Callers can supply a policy class to override that lookup.

`authorize` selects the predicate named for the controller action (defaulting to `action_name`), forwards keyword arguments to it, raises `AuthorizationFailure` when it returns false, and returns the object when authorized. Policy behavior lives in subclasses of `BasePolicy`: predicates can be overridden per action, while its default authorization is denied. The base action mappings are `new?` to `create?`, `edit?` to `update?`, and `destroy?` to `create?`.

`BasePolicy` derives its resource type from the policy class name by removing the `Policy` suffix, and aliases the policy's `object` as the underscored resource name (for example, `DocumentPolicy` exposes `document`). It also exposes the corresponding constantized type class, falling back to `NilClass` when that constant is unavailable.

## Repository conventions

- Tests use ActiveSupport's Minitest test case and live under `test/lib`, following the implementation paths. `test/test_helper.rb` loads the gem and defines the lightweight controller, user, and model fixtures shared by the tests.
- Ruby files use frozen string literal comments and double-quoted strings. RuboCop configuration and its Minitest, packaging, performance, and Rails plugins are in `.rubocop.yml`.
