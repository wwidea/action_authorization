require 'test_helper'

class ActionAuthorizationTest < Minitest::Test
  def test_should_fail_to_authorize_action
    assert_raises ActionAuthorization::AuthorizationFailure do
      authorize(Document.new)
    end
  end

  def test_should_authorize_action
    assert authorize(Document.new(owner: 'Zachary'))
  end

  def test_should_return_corresponding_policy_object
    assert_equal DocumentPolicy, policy(Document.new).class
  end

  def test_should_return_instance_of_supplied_policy_class
    assert_equal DocumentPolicy, policy('test', DocumentPolicy).class
  end

  def test_that_it_has_a_version_number
    refute_nil ::ActionAuthorization::VERSION
  end

  private

  def authorize(*args)
    ApplicationController.new.send(:authorize, *args)
  end

  def policy(*args)
    ApplicationController.new.send(:policy, *args)
  end
end
