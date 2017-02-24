require "action_authorization/version"
require "action_authorization/base_policy"

module ActionAuthorization
  def self.included(base)
    base.class_eval do
      helper_method :policy
    end
  end
  
  protected
  
  def authorize(object, action: action_name, policy_class: nil)
    policy(object, policy_class).send("#{action}?") ? object : raise("not authorized")
  end
  
  def policy(object, policy_class = nil)
    (policy_class || policy_class_for(object)).new(current_user, object)
  end
  
  def policy_class_for(object)
    "#{object.class.name}Policy".constantize
  end
end
