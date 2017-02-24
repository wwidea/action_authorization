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
  def show?
    document.respond_to?(:allow_show) ? document.allow_show : false
  end
end

class Document
  attr_accessor :allow_show
  
  def initialize(allow_show = false)
    self.allow_show = allow_show
  end
end

class User
  def name
    'Test User'
  end
end
