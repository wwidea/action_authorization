# frozen_string_literal: true

require_relative "lib/action_authorization/version"

Gem::Specification.new do |spec|
  spec.name          = "action_authorization"
  spec.version       = ActionAuthorization::VERSION
  spec.authors       = ["Aaron Baldwin", "Brightways Learning"]
  spec.email         = ["baldwina@brightwayslearning.org"]
  spec.homepage      = "https://github.com/wwidea/action_authorization"
  spec.summary       = "Rails controller object-level action authorization."
  spec.description   = "A base policy class for authorizing controller actions with access to the current_user and object."
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.required_ruby_version = ">= 2.7.0"
  spec.add_runtime_dependency "activesupport", ">= 5.0"
end
