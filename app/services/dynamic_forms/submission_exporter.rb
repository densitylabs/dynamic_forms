require 'csv'
require 'axlsx'

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
      @header = build_header
    end

    def export
      case @format_type
      when 'csv'
        to_csv
      when 'xlsx'
        to_xlsx
      else
        raise ArgumentError, 'This format is not available'
      end
    end

    private

    def to_csv
      CSV.generate(headers: true) do |csv|
        csv << @header

        @submissions.each do |submission|
          csv << build_row(submission)
        end
      end
    end

    def to_xlsx
      xlsx = Axlsx::Package.new do |xlsx|
        xlsx.workbook.add_worksheet(name: 'Submissions') do |sheet|
          sheet.add_row @header

          @submissions.each do |submission|
            sheet.add_row build_row(submission)
          end
        end
      end
      xlsx.to_stream.read
    end

    def build_row(submission)
      [].tap do |row|
        row[0] = submission.created_at.strftime(FORMAT_DATE)
        submission.fields.each do |key, value|
          column_name = key.capitalize
          column_index = @header.find_index(column_name)

          row[column_index] = value
        end
      end
    end

    def build_header
      ['Created at'] + field_keys
    end

    def field_keys
      Submission
        .select('json_object_keys(fields) as field_keys')
        .distinct.map{ |s| s.field_keys.capitalize }
    end
  end
end
