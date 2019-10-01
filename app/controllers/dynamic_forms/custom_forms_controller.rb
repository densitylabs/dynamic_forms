require_dependency "dynamic_forms/application_controller"

module DynamicForms
  class CustomFormsController < DynamicForms::ApplicationController
    before_action :load_custom_form, only: %w[edit update destroy show]

    def index
      @custom_forms = CustomForm.page(params[:page])
      render :index
    end

    def new
      @custom_form = CustomForm.new
    end

    def create
      @custom_form = CustomForm.new(custom_forms_params)
      if @custom_form.save
        flash[:success] = "Custom form was successfully created"
        redirect_to custom_forms_path
      else
        flash[:error] =  "Something is wrong, try again"
        render :new
      end
    end

    def edit; end

    def update
      if @custom_form.update(custom_forms_params)
        flash[:success] = "Custom form was successfully created"
        redirect_to custom_forms_path
      else
        flash[:error] =  "Something is wrong, try again"
        render :edit
      end
    end

    def destroy
      if @custom_form.destroy
        flash[:success] = "Custom form was successfully destroyed"
      else
        flash[:error] =  "Custom form couldn't be destroyed, try again"
      end
      redirect_to custom_forms_path
    end

    private

    def custom_forms_params
      params.require(:custom_form).permit(
        :name,
        :restrict_domian,
        :target_email,
        :enabled,
        :allow_notifications,
        :allow_recording_submissions,
      )
    end

    def load_custom_form
      @custom_form = CustomForm.friendly.find(params[:id])
    rescue
      flash[:error] =  "Custom form was not found"
      redirect_to custom_forms_path
    end
  end
end
