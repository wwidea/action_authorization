# frozen_string_literal: true

require "action_authorization"

class ApplicationController
  def self.helper_methods
    @helper_methods ||= []
  end

  def self.helper_method(*methods)
    helper_methods.concat(methods)
  end

  include ActionAuthorization

  def current_user
    User.new
  end

  def action_name
    "show"
  end
end

class DocumentPolicy < ActionAuthorization::BasePolicy
  def submit?(status:)
    status == "draft"
  end

  private

  def authorized?
    document.owner == user.name
  end
end

class FooBarPolicy < ActionAuthorization::BasePolicy
end

class Document
  attr_accessor :folder, :owner

  delegate :model_name, to: :class

  def self.model_name
    name
  end

  def initialize(owner: "Audrey", folder: nil)
    self.owner = owner
    self.folder = folder
  end
end

class Folder
  ModelName = Struct.new(:element)

  def model_name
    ModelName.new("folder")
  end
end

class User
  def name
    "Zachary"
  end
end
