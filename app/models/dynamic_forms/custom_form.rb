require 'json_schemer'

module DynamicForms
  class CustomForm < ApplicationRecord
    extend FriendlyId
    DF_SCHEMA= {
      "type": "object",
      "required":["properties"],
      "properties": {
        "properties": {
          "type": "object"
        }
      }}.freeze
    friendly_id :slug, use: :slugged

    has_many :submissions

    validates :name, presence: true
    validates_uniqueness_of :slug
    validate :multi_emails
    validate :json_schema_format

    before_create :assign_slug

    def json_schema_available?
       is_json_schema_enabled? && json_schema.present?
    end

    def ui_schema_available?
       is_ui_schema_enabled? && ui_schema.present?
    end

    private

    def assign_slug
      self.slug = SecureRandom.hex(12)
    end

    def can_save_record?
      allow_recording_submissions
    end

    def json_schema_format
      return unless is_json_schema_enabled?
      return unless json_schema

      schemer = JSONSchemer.schema(DF_SCHEMA.to_json)
      unless schemer.valid?(JSON.parse(json_schema))
        errors.add(:json_schema, I18n.t('custom_errors.json_schema'))
      end
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
