require "active_support/core_ext/module/delegation"
require "active_support/core_ext/string/inflections"
require "action_authorization/version"
require "action_authorization/base_policy"
require "action_authorization/authorization_failure"

module ActionAuthorization
  def self.included(base)
    base.class_eval do
      helper_method :policy
    end
  end

  protected

  def authorize(object, action: action_name, policy_class: nil)
    if policy(object, policy_class).send("#{action}?")
      object
    else
      raise ActionAuthorization::AuthorizationFailure
    end
  end

  def policy(object, policy_class = nil)
    (policy_class || policy_class_for(object)).new(current_user, object)
  end

  def policy_class_for(object)
    "#{object.class.name}Policy".constantize
  end
end
