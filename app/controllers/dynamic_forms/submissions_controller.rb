require_dependency "dynamic_forms/application_controller"

module DynamicForms
  class SubmissionsController < DynamicForms::ApplicationController
    before_action :load_custom_form
    before_action :load_submission, only: %i[destroy]
    before_action :load_submissions, only: %i[index export]

    def index
      respond_to do |format|
        format.html
        format.csv { export_as('csv') }
        format.xlsx { export_as('xlsx') }
      end
    end

    def destroy
      if @submission.destroy
        flash[:success] = I18n.t('submission.flash_messages.success.destroy')
      else
        flash[:error] = I18n.t('submission.flash_messages.error.general')
      end
      redirect_to custom_form_submissions_path(@custom_form)
    end


    private

    def load_custom_form
      @custom_form = CustomForm.friendly.find(params[:custom_form_id])
    rescue
      flash[:error] = I18n.t('custom_form.flash_messages.error.no_found')
      redirect_to custom_forms_path
    end

    def load_submissions
      @submissions = @custom_form.submissions
                                   .order('created_at DESC')
                                   .page(params[:page])
    end

    def load_submission
      @submission = @custom_form.submissions.find(params[:id])
    rescue
      flash[:error] = I18n.t('submission.flash_messages.error.no_found')
      redirect_to custom_form_path(@custom_form)
    end

    def export_as(type)
      send_data(
        SubmissionExporter.for(@custom_form.submissions.order('created_at'), type),
        filename: "submissions-#{Date.today}.#{type}"
      )
    end
  end
end
