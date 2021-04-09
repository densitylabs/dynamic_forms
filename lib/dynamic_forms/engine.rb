module DynamicForms
  class Engine < ::Rails::Engine
    isolate_namespace DynamicForms

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end
    initializer "dynamic_forms.assets.precompile" do |app|
      app.config.assets.precompile += %w( dynamic_forms/application.js dynamic_forms/application.css )
    end
  end
end
