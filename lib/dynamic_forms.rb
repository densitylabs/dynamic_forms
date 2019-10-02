require "dynamic_forms/engine"

module DynamicForms
  mattr_accessor :layout

  def self.config
    yield(self)
  end
end
