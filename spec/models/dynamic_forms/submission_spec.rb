require 'rails_helper'

describe DynamicForms::Submission, type: :model  do
  it { should belong_to(:custom_form) }
  it { validate_presence_of(:fields) }

  describe 'custom validations' do
    context 'when custom form has json_schema enabled' do
      let(:custom_form) { create(:custom_form, :with_json_schema) }
      describe '#json_schema' do
        context 'when is valid' do
          let(:submission) { build(:submission, custom_form: custom_form) }
          it 'does not return an error' do
            submission.valid?
            expect(submission.errors.messages[:base].count).to eq(0)
          end
        end
        context 'When is invalid' do
          let(:submission) { build(:submission, custom_form: custom_form, fields: {name: nil}) }
          it 'returns an error' do
            submission.valid?
            expect(submission.errors.messages[:base].count).to eq(1)
          end
        end
      end
    end
    context 'When custom form has not json_schema enabled' do
      let(:custom_form) { create(:custom_form) }
      let(:submission) { build(:submission, custom_form: custom_form) }
      it 'returns an error' do
        submission.valid?
        expect(submission.errors.messages[:base].count).to eq(0)
      end
    end
  end
end
