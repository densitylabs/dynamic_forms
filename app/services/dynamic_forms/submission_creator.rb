module DynamicForms
  class SubmissionCreator
    def self.for(params, custom_form)
      new(params, custom_form).create
    end

    def initialize(params, custom_form)
      @params = params
      @custom_form = custom_form
    end

    def create
      submission = @custom_form.submissions.new(@params)
      submission.save() if @custom_form.allow_recording_submissions?
      submission
    rescue
      raise submission.errors.full_messages if submission
      raise 'Information cannot be recorded'
    end
  end
end
