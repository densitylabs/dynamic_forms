require 'rails_helper'

describe DynamicForms::CustomForm, type: :model  do
  describe 'Associations' do
    it { should have_many(:submissions) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:slug) }
  end

  context 'custom validations' do
    let(:custom_form) { build(:custom_form, target_email: 'email@mail.com example') }
    it 'validates #multi_emails' do
      custom_form.valid?
      expect(custom_form.errors.messages[:base].count).to eq(1)
    end
  end
end
