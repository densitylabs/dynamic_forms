require "dynamic_forms/engine"
require 'active_model_serializers'

module DynamicForms
  mattr_accessor :layout

  def self.config
    yield(self)
  end
end
