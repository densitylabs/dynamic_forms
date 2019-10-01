# this code is based on http://www.candland.net/2012/04/17/rails-routes-used-in-an-isolated-engine/
module DynamicForms
  module ApplicationHelper
    def method_missing method, *args, &block
      return super unless method.to_s.end_with?('_path','_url')

      main_app.respond_to?(method) ? main_app.send(method, *args) : super
    end

    def respond_to?(method, include_private = false)
      return super unless method.to_s.end_with?('_path','_url')

      main_app.respond_to?(method) ? true : super
    end
  end
end
