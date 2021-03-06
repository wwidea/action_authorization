# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'action_authorization/version'

Gem::Specification.new do |spec|
  spec.name          = "action_authorization"
  spec.version       = ActionAuthorization::VERSION
  spec.authors       = ["Aaron Baldwin"]
  spec.email         = ["baldwina@brightwayslearning.org"]

  spec.summary       = %q{Rails controller object-level action authorization.}
  spec.description   = %q{A base policy class for authorizing controller actions with access to the current_user and object.}
  spec.homepage      = "https://github.com/wwidea/action_authorization"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "activesupport",  ">= 5.0"

  spec.add_development_dependency "bundler",        "~> 2.1"
  spec.add_development_dependency "rake",           "~> 13.0"
  spec.add_development_dependency "guard",          "~> 2.14"
  spec.add_development_dependency "guard-minitest", "~> 2.4"
end
