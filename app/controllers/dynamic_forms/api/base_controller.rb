require 'active_model_serializers'
module DynamicForms
  module Api
    class BaseController < ActionController::Base
      include ActionController::Serialization
      before_action :set_cors

      private
      def set_cors
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      end
    end
  end
end
