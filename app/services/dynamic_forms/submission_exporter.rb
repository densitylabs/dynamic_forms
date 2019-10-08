require 'csv'

module DynamicForms
  class SubmissionExporter
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
        as_csv
      when 'xls'
        as_xls
      else
        raise ArgumentError, 'This format is not available'
      end
    end

    private

    def as_csv

      CSV.generate(headers: true) do |csv|
        csv << build_header
        binding.pry
        csv.binmode.each do |row|
          binding.pry
        end
      end
    end

    def as_xls
    end

    def build_header
      [].tap do |header|
        @submissions.each do |submission|
          submission.fields.keys.each do |attribute|
            column = attribute.downcase
            header.push(column) unless header.include?(column)
          end
        end
      end
    end
  end
end
