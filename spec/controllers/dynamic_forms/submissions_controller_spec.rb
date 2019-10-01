require 'rails_helper'

describe DynamicForms::SubmissionsController, type: :controller do
  routes { DynamicForms::Engine.routes }

  let!(:custom_form) { create(:custom_form) }
  let!(:submission) { create(:submission, custom_form: custom_form) }

  describe '#index' do
    it 'renders index template' do
        get :index, params: { custom_form_id: custom_form.slug }
      expect(response).to render_template :index
    end

    it 'retrieves all submissions' do
      get :index, params: { custom_form_id: custom_form.slug }
      expect(assigns(:submissions).count).to eq(1)
    end

    context 'When custom form id is not correct' do
      it 'redirects to  custom forms index' do
        get :index, params: { custom_form_id: 'asd98asdjn32rr89asdb' }
        expect(response).to redirect_to custom_forms_path
      end
    end
  end

  describe '#destroy' do
    it 'returns' do
      delete :destroy, params: { id: submission.id, custom_form_id: custom_form.slug }
      expect(custom_form.submissions.count).to eq(0)
    end
  end
end
