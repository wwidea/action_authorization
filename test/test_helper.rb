$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'action_authorization'

require 'minitest/autorun'

class ApplicationController
  def self.helper_method(*_args)
    # not implemented
  end
  
  include ActionAuthorization
end
