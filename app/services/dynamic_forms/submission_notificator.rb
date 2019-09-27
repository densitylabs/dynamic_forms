module DynamicForms
  class SubmissionNotificator
    def self.for(submission)
      new(submission).send_email
    end

    def initialize(submission)
      @submission = submission
      @custom_form = submission.custom_form
    end

    def send_email
      return unless @custom_form.allow_notifications?
      return unless @custom_form.target_email.present?

      SubmissionMailer.notify_submission(@submission).deliver_now
    rescue
      raise 'The email cannot be sent'
    end
  end
end
