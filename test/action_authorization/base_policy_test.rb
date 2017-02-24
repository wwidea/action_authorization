require 'test_helper'

class ActionAuthorization::BasePolicyTest < Minitest::Test
  def test_should_initialize_with_user_and_object
    policy = document_policy
    
    assert_equal 'Test User', policy.user.name
    assert_equal 'testing',   policy.object
  end
  
  def test_should_create_alias_to_object_based_on_policy_class_name
    assert_equal 'testing', document_policy.document
  end
  
  def test_action_authorization_should_default_to_false
    %w(index? show? new? create? edit? update? destroy?).each do |method|
      refute document_policy.send(method)
    end
  end
  
  private
  
  def document_policy
    DocumentPolicy.new(User.new, 'testing')
  end
end
