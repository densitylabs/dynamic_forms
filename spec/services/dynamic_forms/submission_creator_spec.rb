require 'rails_helper'
describe DynamicForms::SubmissionCreator do
  context 'when custom_form allow recording submissions' do
    let!(:custom_form) { create(:custom_form) }
    let(:params) { attributes_for(:submission, custom_form: custom_form)}
    it 'create a submission' do
      DynamicForms::SubmissionCreator.for(params, custom_form)
      expect(custom_form.submissions.count).to eq(1)
    end
  end
  context 'when custom_form not allow recording submissions' do
    let!(:custom_form) { create(:custom_form, allow_recording_submissions: false) }
    let(:params) { attributes_for(:submission, custom_form: custom_form)}
    it 'does not create a submission' do
      DynamicForms::SubmissionCreator.for(params, custom_form)
      expect(custom_form.submissions.count).to eq(0)
    end
  end
end
