# frozen_string_literal: true

require "test_helper"

module ActionAuthorization
  class BasePolicyTest < ActiveSupport::TestCase
    test "should initialize with user and object" do
      policy = document_policy

      assert_equal "Zachary", policy.user.name
      assert_equal "Audrey",  policy.object.owner
    end

    test "should initialize with only a user" do
      assert_nil DocumentPolicy.new(User.new).object
    end

    test "should create alias to object based on policy class name" do
      assert document_policy.document
    end

    test "action authorization should default to false" do
      assert_authorized_action_methods(ActionAuthorization::BasePolicy.new("user", "object"), false)
    end

    test "action authorization should return true" do
      assert_authorized_action_methods(DocumentPolicy.new(User.new, Document.new(owner: "Zachary")), true)
    end

    test "should return policy type" do
      assert_equal "Document", document_policy.type
    end

    test "should return policy class" do
      assert_equal Document, document_policy.type_class
    end

    test "should return nil class for policy class" do
      assert_equal NilClass, FooBarPolicy.type_class
    end

    private

    def document_policy
      DocumentPolicy.new(User.new, Document.new)
    end

    def foobar_policy
      FooBarPolicy.new(User.new, Document.new)
    end

    def assert_authorized_action_methods(policy, value)
      %w[index? show? new? create? edit? update? destroy?].each do |method|
        assert_equal value, policy.send(method)
      end
    end
  end
end
