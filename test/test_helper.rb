$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'action_authorization'

require 'minitest/autorun'

class ApplicationController
  def self.helper_method(method)
    method
  end
  
  include ActionAuthorization
end

class DocumentPolicy < ActionAuthorization::BasePolicy
end

class User
  def name
    'Test User'
  end
end
