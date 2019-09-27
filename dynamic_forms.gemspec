$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dynamic_forms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dynamic_forms"
  s.version     = DynamicForms::VERSION
  s.authors     = ["Alejandro Prado"]
  s.email       = ["alejandro.prado@densitylabs.io"]
  s.homepage    = ""
  s.summary     = "Summary of DynamicForms."
  s.description = "Description of DynamicForms."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.0"
  s.add_dependency "pg"
  s.add_dependency "kaminari"
  s.add_dependency "friendly_id", '~> 5.2.4'
end
