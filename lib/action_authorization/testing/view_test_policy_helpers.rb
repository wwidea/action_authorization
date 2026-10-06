# frozen_string_literal: true

module ActionAuthorization
  module Testing
    module ViewTestPolicyHelpers
      include PolicyHelpers
      include PolicyStub

      private

      def policy_class_default
        OpenPolicy
      end

      def view_policy_stub
        view.stubs(:policy).returns(policy)
      end
    end
  end
end
