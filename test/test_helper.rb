$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'action_authorization'

require 'minitest/autorun'

class ApplicationController
  def self.helper_method(method)
    method
  end

  include ActionAuthorization

  def current_user
    User.new
  end

  def action_name
    'show'
  end
end

class DocumentPolicy < ActionAuthorization::BasePolicy

  private

  def authorized?
    document.owner == user.name
  end
end

class Document
  attr_accessor :owner

  def initialize(owner: 'Audrey')
    self.owner = owner
  end
end

class User
  def name
    'Zachary'
  end
end
