# frozen_string_literal: true

module ActionAuthorization
  module Testing
    module IntegrationTestPolicyHelpers
      include PolicyHelpers

      private

      def policy_class_default
        self.class.name.sub("ControllerTest", "").singularize.concat("Policy").constantize
      end
    end
  end
end
