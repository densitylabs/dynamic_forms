module DynamicForms
  class CustomForm < ApplicationRecord
    extend FriendlyId
    friendly_id :slug, use: :slugged

    has_many :submissions

    validates :name, presence: true
    validates :target_email, format: { with: URI::MailTo::EMAIL_REGEXP },
      allow_blank: true
    validates_uniqueness_of :slug

    before_create :assign_slug

    private

    def assign_slug
      self.slug = SecureRandom.hex(12)
    end

    def can_save_record?
      allow_recording_submissions
    end
  end
end
