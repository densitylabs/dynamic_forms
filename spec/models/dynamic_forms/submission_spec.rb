require 'rails_helper'

describe DynamicForms::Submission, type: :model  do
  it { should belong_to(:custom_form) }
  it { validate_presence_of(:fields) }
end
