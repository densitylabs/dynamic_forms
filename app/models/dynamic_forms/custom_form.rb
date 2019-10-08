module DynamicForms
  class CustomForm < ApplicationRecord
    extend FriendlyId
    friendly_id :slug, use: :slugged

    has_many :submissions

    validates :name, presence: true
    validates_uniqueness_of :slug
    validate :multi_emails

    before_create :assign_slug

    private

    def assign_slug
      self.slug = SecureRandom.hex(12)
    end

    def can_save_record?
      allow_recording_submissions
    end

    def multi_emails
      return unless target_email

      target_email.split(',').each do |email|
        unless URI::MailTo::EMAIL_REGEXP.match?(email)
          errors.add(:base,
            "'#{email}' #{I18n.t('custom_errors.invalid_mail')}")
        end
      end
    end
  end
end
