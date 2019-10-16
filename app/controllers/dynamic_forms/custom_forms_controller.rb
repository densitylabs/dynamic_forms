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
        flash[:success] = I18n.t('custom_form.flash_messages.success.create')
        redirect_to custom_forms_path
      else
        flash[:error] =  I18n.t('custom_form.flash_messages.error.general')
        render :new
      end
    end

    def edit; end

    def update
      if @custom_form.update(custom_forms_params)
        flash[:success] = I18n.t('custom_form.flash_messages.success.update')
        redirect_to custom_forms_path
      else
        flash[:error] =  I18n.t('custom_form.flash_messages.error.general')
        render :edit
      end
    end

    def destroy
      if @custom_form.destroy
        flash[:success] = I18n.t('custom_form.flash_messages.success.destroy')
      else
        flash[:error] =  I18n.t('custom_form.flash_messages.error.general')
      end
      redirect_to custom_forms_path
    end

    private

    def custom_forms_params
      params.require(:custom_form).permit(
        :name,
        :restrict_domain,
        :target_email,
        :enabled,
        :allow_notifications,
        :allow_recording_submissions,
        :is_schema_enabled,
        :json_schema
      )
    end

    def load_custom_form
      @custom_form = CustomForm.friendly.find(params[:id])
    rescue
      flash[:error] = I18n.t('custom_form.flash_messages.error.no_found')
      redirect_to custom_forms_path
    end
  end
end
