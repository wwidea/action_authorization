# frozen_string_literal: true

require "test_helper"

class ActionAuthorizationTest < ActiveSupport::TestCase
  test "should fail to authorize action" do
    assert_raises ActionAuthorization::AuthorizationFailure do
      authorize(Document.new)
    end
  end

  test "should authorize action" do
    assert authorize(Document.new(owner: "Zachary"))
  end

  test "should return corresponding policy object" do
    assert_instance_of DocumentPolicy, policy(Document.new)
  end

  test "should return instance of supplied policy class" do
    assert_instance_of DocumentPolicy, policy("test", DocumentPolicy)
  end

  test "that it has a version number" do
    assert_not_nil ::ActionAuthorization::VERSION
  end

  private

  def authorize(*args)
    ApplicationController.new.send(:authorize, *args)
  end

  def policy(*args)
    ApplicationController.new.send(:policy, *args)
  end
end
