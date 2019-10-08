require 'rails_helper'

describe DynamicForms::CustomForm, type: :model  do
  describe 'Associations' do
    it { should have_many(:submissions) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe 'custom validations' do
    subject { build(:custom_form, target_email: emails) }
    describe '#multi_emails' do
      context 'when are valid' do
        let(:emails) {'email@mail.com,another@mail.com'}
        it 'does not return an error' do
          subject.valid?
          expect(subject.errors.messages[:base].count).to eq(0)
        end
      end
      context 'When are invalid' do
        let(:emails) { 'email@mail.com/another@mail.com, '\
           'email@mail.com:another@mail.com, '\
           'email@mail.com|another@mail.com' }
        it 'returns an error' do
          subject.valid?
          expect(subject.errors.messages[:base].count).to eq(3)
        end
      end
    end
  end
end
