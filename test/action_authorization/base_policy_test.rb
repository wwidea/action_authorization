require 'test_helper'

class ActionAuthorization::BasePolicyTest < Minitest::Test
  def test_should_initialize_with_user_and_object
    policy = document_policy
    
    assert_equal 'Zachary', policy.user.name
    assert_equal 'Audrey',  policy.object.owner
  end
  
  def test_should_create_alias_to_object_based_on_policy_class_name
    assert document_policy.document
  end
  
  def test_action_authorization_should_default_to_false
    assert_authorized_action_methods(EmptyPolicy.new('user', 'object'), false)
  end
  
  def test_action_authorization_should_return_true
    assert_authorized_action_methods(DocumentPolicy.new(User.new, Document.new(owner: 'Zachary')), true)
  end
  
  private
  
  def document_policy
    DocumentPolicy.new(User.new, Document.new)
  end
  
  def assert_authorized_action_methods(policy, value)
    %w(index? show? new? create? edit? update? destroy?).each do |method|
      assert_equal value, policy.send(method)
    end
  end
end
