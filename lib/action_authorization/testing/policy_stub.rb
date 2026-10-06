# frozen_string_literal: true

module ActionAuthorization
  module Testing
    module PolicyStub
      def policy(*)
        OpenPolicy.new
      end
      alias policy_for policy
    end
  end
end
