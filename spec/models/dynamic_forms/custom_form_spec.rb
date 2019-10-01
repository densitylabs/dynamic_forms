require 'rails_helper'

describe DynamicForms::CustomForm, type: :model  do
  describe 'Associations' do
    it { should have_many(:submissions) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:slug) }
  end
end
