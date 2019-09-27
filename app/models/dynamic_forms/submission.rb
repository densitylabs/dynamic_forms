module DynamicForms
  class Submission < ApplicationRecord
    belongs_to :custom_form

    validates :fields, presence: true
  end
end
