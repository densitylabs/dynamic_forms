require 'json_schemer'

module DynamicForms
  class Submission < ApplicationRecord
    belongs_to :custom_form

    validates :fields, presence: true

    validate :json_schema

    private

    def json_schema
      return unless custom_form&.json_schema_available?

      schemer = JSONSchemer.schema(custom_form.json_schema)
      unless schemer.valid?(fields)
        errors.add(:base, decode_json_schemer_errors(schemer.validate(fields).first))
      end
    end

    def decode_json_schemer_errors(error)
      messages = []

      formatted_data_pointer = format_data_pointer error['data_pointer']

      case error['type']
      when 'required'
        if error['details'].key? 'missing_keys'
          messages << "#{formatted_data_pointer}is missing required keys '"\
            "#{error["details"]["missing_keys"].join(", ")}'"
        else
          messages << "#{formatted_data_pointer}is missing required keys"
        end
      when 'schema'
        if error["schema_pointer"] == '/additionalProperties'
          messages << "contains unrecognized property '#{formatted_data_pointer}'"
        else
          messages << "does not validate: schema_pointer=#{error['schema_pointer']}"
        end
      when 'string'
        messages << "property '#{formatted_data_pointer}' should be a string"
      when 'boolean'
        messages << "property '#{formatted_data_pointer}' should be a boolean"
      when 'integer'
        messages << "property '#{formatted_data_pointer}' should be a number"
      when 'object'
        messages << "property '#{formatted_data_pointer}' should be an object"
      when 'pattern'
        messages << "property '#{formatted_data_pointer}' does not match "\
          "pattern: #{error["schema"]["pattern"]}"
      when 'format'
        messages << "property '#{formatted_data_pointer}' does not match "\
          "format: #{error['schema']['format']}"
      else
        messages << "does not validate: error_type=#{error['type']}"
      end

      messages.flatten.join ', '
    end

    def format_data_pointer(data_pointer)
      data_pointer = data_pointer
        .sub(%r|^/|, '')
        .sub('/', '.')
        .capitalize
    end
  end
end
