require 'rails_helper'

describe DynamicForms::Api::FormController, type: :controller do
  routes { DynamicForms::Engine.routes }

  let!(:custom_form) { create(:custom_form) }

  let(:params) {
    {
      uuid: custom_form.slug,
      name: 'John',
      email: 'john@mail.com',
      _subject: 'Email test',
    }
  }

  describe '#create' do
    context 'when honey_pot filter is applied' do
      it 'returns a unprocessable_entity status' do
        post :create, params: params.merge({_trap: 'something'})
        expect(response.status).to eq(422)
      end
    end
    context 'when custom_form is not valid' do
      it 'returns a not_found status' do
        post :create, params: params.merge({uuid: 'asda98ashjdas9yahijd'})
        expect(response.status).to eq(404)
      end
    end
    context 'when custom form is not enabled' do
      before do
        custom_form.update(enabled: false)
        custom_form.reload
      end
      it 'returns a unauthorized status' do
        post :create, params: params
        expect(response.status).to eq(404)
      end
    end
    context 'when custom form has a restrict_domain' do
      before do
        custom_form.update(restrict_domain: 'custom_domian.com')
        custom_form.reload
      end
      it 'returns a unauthorized status' do
        post :create, params: params
        expect(response.status).to eq(401)
      end
    end

    context 'when request passes all filters' do
      it 'retuns a ok status' do
        post :create, params: params
        expect(response.status).to eq(200)
      end
      it 'creates a new submission' do
        post :create, params: params
        expect(custom_form.submissions.count).to eq(1)
      end
    end
  end

  describe '#show' do
    context 'when schema is enabled' do
      before do
        custom_form.update(
          is_schema_enabled: true,
          json_schema: {
            "title": "example"
          }.to_json
        )
        custom_form.reload
      end
      it 'retuns the ok status' do
        get :show, params: params.merge({_trap: 'something'})
        expect(response.status).to eq(200)
      end
    end
    context 'when schema is not enabled' do
      before do
        custom_form.update(is_schema_enabled: false)
        custom_form.reload
      end
      it 'returns a unprocessable_entity status' do
        get :show, params: params.merge({_trap: 'something'})
        expect(response.status).to eq(422)
      end
    end
  end
end
