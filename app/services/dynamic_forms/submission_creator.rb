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
      return submission unless @custom_form.allow_recording_submissions?
      raise unless submission.save()
      submission
    rescue
      raise submission.errors.full_messages.join(',') if submission
      raise 'Information cannot be recorded'
    end
  end
end
