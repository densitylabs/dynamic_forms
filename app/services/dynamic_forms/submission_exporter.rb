require 'csv'

module DynamicForms
  class SubmissionExporter
    FORMAT_DATE = '%B %m, %Y, %H:%M'.freeze

    def self.for(submissions, format_type)
      new(submissions, format_type).export
    end

    def initialize(submissions, format_type)
      raise TypeError, "Expected an string, got #{format_type.class.name}" unless format_type.is_a?(String)
      raise ArgumentError, 'Expected submissions' if submissions.nil?

      @submissions = submissions
      @format_type = format_type
    end

    def export
      case @format_type
      when 'csv'
        to_csv
      when 'xls'
        to_xls
      else
        raise ArgumentError, 'This format is not available'
      end
    end

    private

    def to_csv
      CSV.generate(headers: true) do |csv|
        header = ['Created at'] + build_header
        csv << header

        @submissions.each do |submission|
          csv << [].tap do |row|
            row[0] = submission.created_at.strftime(FORMAT_DATE)
            submission.fields.each do |key, value|
              column_name = key.capitalize
              column_index = header.find_index(column_name)

              row[column_index] = value
            end
          end
        end

        @submissions.map do |submission|
          header.each do |column|
            column_name = column.downcase

          end
        end
      end
    end

    def to_xls
    end

    def build_header
      Submission
        .select('json_object_keys(fields) as field_keys')
        .distinct.map{ |s| s.field_keys.capitalize }
    end
  end
end
