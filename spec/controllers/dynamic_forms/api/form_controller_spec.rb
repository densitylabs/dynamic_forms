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
    context 'when custom form has a restrict_domian' do
      before do
        custom_form.update(restrict_domian: 'custom_domian.com')
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
end
