require_dependency "dynamic_forms/application_controller"

module DynamicForms
  module Api
    class FormController < ActionController::Base
      UNECESSARY_PARAMS = %w[action controller uuid]

      skip_before_action :verify_authenticity_token
      before_action :honey_pot, only: [:create]
      before_action :set_custom_form
      before_action :validations
      before_action :remove_unnecessary_params, only: [:create]

      def create
        submission = SubmissionCreator.for(custom_params, @custom_form)
        SubmissionNotificator.for(submission)
        render json: {message: "Information was successfully sent"}, status: :ok
      rescue => e
        return render json:
          { message: e.message },
          status: :unprocessable_entity
      end

      private

      def custom_params
        return if params.empty?

        {
          fields: params.as_json,
          request_url: request.url
        }
      end

      def honey_pot
        if params['_trap'] && !params['_trap'].blank?
          return render json: {}, status: :unprocessable_entity
        end
      end

      def validations
        return render json: {}, status: :not_found unless @custom_form.enabled
        return unless @custom_form.restrict_domian.present?

        unless request.domain == @custom_form.restrict_domian
          return render json: {}, status: :unauthorized
        end
      end

      def set_custom_form
        @custom_form = CustomForm.friendly.find_by(slug: params[:uuid])
        return render json: {}, status: :not_found unless @custom_form
      end

      def remove_unnecessary_params
        UNECESSARY_PARAMS.each do |item|
          params.delete(item)
        end
      end
    end
  end
end
