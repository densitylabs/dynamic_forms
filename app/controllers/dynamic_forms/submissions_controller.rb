require_dependency "dynamic_forms/application_controller"

module DynamicForms
  class SubmissionsController < DynamicForms::ApplicationController
    before_action :load_custom_form
    before_action :load_submission, only: %i[destroy]
    before_action :load_submissions, only: %i[index export]

    def index
      respond_to do |format|
        format.html
        format.csv { 
          send_data SubmissionExporter.for(@submissions, 'csv'), 
          filename: "submissions-#{Date.today}.csv" 
        }
      end
    end

    def destroy
      if @submission.destroy
        flash[:success] = "Submission was successfully destroyed"
      else
        flash[:error] = "Submission couldn't be destroyed, try again"
      end
      redirect_to custom_form_submissions_path(@custom_form)
    end


    private

    def load_custom_form
      @custom_form = CustomForm.friendly.find(params[:custom_form_id])
    rescue
      flash[:error] =  "Custom form was not found"
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
      flash[:error] =  "Submission was not found"
      redirect_to custom_form_path(@custom_form)
    end
  end
end
