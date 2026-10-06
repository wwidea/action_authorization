# frozen_string_literal: true

module ActionAuthorization
  module Testing
    class OpenPolicy < ActionAuthorization::BasePolicy
      def initialize
        super(nil, nil)
      end

      # Any predicate (ending in "?") is allowed, including non-standard actions.
      def method_missing(method_name, *, &)
        predicate?(method_name) || super
      end

      def respond_to_missing?(method_name, include_private = false)
        predicate?(method_name) || super
      end

      private

      def authorized?
        true
      end

      def predicate?(method_name)
        method_name.end_with?("?")
      end
    end
  end
end
