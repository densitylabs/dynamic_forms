require 'rails_helper'
describe DynamicForms::SubmissionNotificator do
  context 'when custom_form allow notifications and has a target_email' do
    let(:custom_form) { create(:custom_form, target_email: 'test@mail.com') }
    let(:submission) {create(:submission, custom_form: custom_form)}
    it 'sends an email' do
      expect{ DynamicForms::SubmissionNotificator.for(submission) }.to change(ActionMailer::Base.deliveries, :count)
    end
  end
  context 'When a custom_form not allow notifications' do
    let(:custom_form) { create(:custom_form, target_email: 'test@mail.com', allow_notifications: false) }
    let(:submission) { create(:submission, custom_form: custom_form)}
    it 'does not send an email' do
      expect{ DynamicForms::SubmissionNotificator.for(submission) }.to_not change(ActionMailer::Base.deliveries, :count)
    end
  end
  context 'When a custom_form does not have a target_mail' do
    let(:custom_form) { create(:custom_form, allow_notifications: false) }
    let(:submission) { create(:submission, custom_form: custom_form)}
    it 'does not send an email' do
      expect{ DynamicForms::SubmissionNotificator.for(submission) }.to_not change(ActionMailer::Base.deliveries, :count)
    end
  end
end
