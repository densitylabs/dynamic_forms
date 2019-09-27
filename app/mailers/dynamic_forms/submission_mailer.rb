
module DynamicForms
  class SubmissionMailer < ApplicationMailer
    def notify_submission(submission)
      @submission = submission
      @custom_form = submission.custom_form
      @request_url = submission.request_url
      @time = submission.created_at || Time.current
      default_subject = "New submission in #{@custom_form.name} form"
      subject = submission.fields['_subject'] || default_subject
      mail(to: @custom_form.target_email, subject: subject)
    end
  end
end
