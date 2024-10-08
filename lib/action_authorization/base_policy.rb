# frozen_string_literal: true

module ActionAuthorization
  class BasePolicy
    attr_accessor :user, :object

    def self.type
      name.delete_suffix("Policy")
    end

    def self.type_class
      type.constantize
    rescue NameError
      NilClass
    end

    delegate :type, :type_class, to: :class

    def initialize(user, object = nil)
      self.user = user
      self.object = object
    end

    # create alias to object from subclass name
    def self.inherited(klass)
      super
      klass.send(:alias_method, klass.type.underscore, :object)
    end

    def index?
      authorized?
    end

    def show?
      authorized?
    end

    def new?
      create?
    end

    def create?
      authorized?
    end

    def edit?
      update?
    end

    def update?
      authorized?
    end

    def destroy?
      create?
    end

    private

    def authorized?
      false
    end
  end
end
