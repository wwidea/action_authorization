# frozen_string_literal: true

module ActionAuthorization
  module Testing
    module PolicyHelpers
      private

      def allow(action, **)
        policy_action_expectation(action, **)
      end

      def forbid(action, **)
        policy_action_expectation(action, **, value: false)
      end

      def policy_action_expectation(action, policy_class: policy_class_default, value: true)
        policy_class.any_instance.expects("#{action}?").returns(value)
      end

      def policy_class_default
        raise NotImplementedError, "You must implement policy_class_default in your test class"
      end
    end
  end
end
