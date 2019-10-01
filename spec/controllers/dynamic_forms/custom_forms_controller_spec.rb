require 'rails_helper'

describe DynamicForms::CustomFormsController, type: :controller do
  routes { DynamicForms::Engine.routes }

  let!(:custom_form) { create(:custom_form) }

  describe '#index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template :index
    end
     it 'retrieves all custom forms' do
       get :index
       expect(assigns(:custom_forms).count).to eq(1)
     end
  end

  describe '#new' do
    it 'creates a new custom_form instance' do
      get :new
      expect(assigns(:custom_form)).to be_a_new(DynamicForms::CustomForm)
    end

    it 'returns new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    it 'redirects to index page' do
      post :create, params: { custom_form: { name: 'Custom Form'} }
      expect(response).to redirect_to custom_forms_path
    end

    it 'creates a new customer' do
      post :create, params: { custom_form: { name: 'New Custom Form'} }
      expect(DynamicForms::CustomForm.last.name).to eq('New Custom Form')
    end

    it 'returns an error' do
      post :create, params: { custom_form: { name: ''}}

      expect(response).to render_template :new
      expect(assigns(:custom_form).errors.count).to eq(1)
    end
  end

  describe '#update' do
    it 'redirects to index page' do
      put :update, params: {
        id: custom_form.id,
        custom_form: {
          name: 'Custom Form2',
          restrict_domian: 'domain.com',
          target_email: 'test@mail.com',
          allow_notifications: false
        }
      }
      expect(response).to redirect_to custom_forms_path
      custom_form.reload
      expect(custom_form.target_email).to eq('test@mail.com')
    end

    it 'returns an error' do
      put :update, params: {
        id: custom_form.id,
        custom_form: {
          name: 'Custom Form2',
          restrict_domian: 'domain.com',
          target_email: 'test',
          allow_notifications: false
        }
      }
      expect(response).to render_template :edit
      expect(assigns(:custom_form).errors.count).to eq(1)
    end
  end

  describe '#destroy' do
    it 'deletes a custom_form' do
      delete :destroy, params: { id: custom_form.id }
      expect(DynamicForms::CustomForm.count).to eq(0)
    end
  end
end
