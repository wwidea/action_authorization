# frozen_string_literal: true

require "active_support/core_ext/module/delegation"
require "active_support/core_ext/string/inflections"
require "action_authorization/version"
require "action_authorization/base_policy"
require "action_authorization/null_policy"
require "action_authorization/authorization_failure"

module ActionAuthorization
  def self.included(base)
    base.class_eval do
      helper_method :policy, :policy_for
    end
  end

  protected

  def authorize(object, action: action_name, policy_class: nil, **)
    raise AuthorizationFailure unless policy(object, policy_class).public_send(:"#{action}?", **)

    object
  end

  def policy(object, policy_class = nil)
    (policy_class || policy_class_for(object)).new(current_user, object)
  end

  def policy_for(object)
    policy(object.is_a?(Array) ? policy_record_for(object) : object)
  end

  def policy_class_for(object)
    object.nil? ? NullPolicy : "#{object.model_name}Policy".constantize
  end

  private

  def policy_record_for(array)
    parent, model = array
    model.new(parent.model_name.element.to_sym => parent)
  end
end
