# frozen_string_literal: true

require "test_helper"

class ActionAuthorizationTest < ActiveSupport::TestCase
  test "authorize document show with owner matching the user" do
    assert authorize(Document.new(owner: "Zachary"))
  end

  test "authorize document show with owner that does not match the user" do
    assert_raises ActionAuthorization::AuthorizationFailure do
      authorize(Document.new(owner: "Test"))
    end
  end

  test "authorize action with additional keyword argument" do
    assert authorize(Document, action: "submit", status: "draft")
  end

  test "authorize action with nil object" do
    assert_raises ActionAuthorization::AuthorizationFailure do
      authorize(nil)
    end
  end

  test "policy for new document" do
    assert_instance_of DocumentPolicy, policy(Document.new)
  end

  test "policy with specified policy class" do
    assert_instance_of DocumentPolicy, policy("test", DocumentPolicy)
  end

  test "policy for nil object" do
    assert_instance_of ActionAuthorization::NullPolicy, policy(nil)
  end

  private

  def authorize(object, **)
    ApplicationController.new.send(:authorize, object, **)
  end

  def policy(*)
    ApplicationController.new.send(:policy, *)
  end
end
