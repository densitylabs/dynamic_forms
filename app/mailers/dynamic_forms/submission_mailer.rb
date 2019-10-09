
module DynamicForms
  class SubmissionMailer < ApplicationMailer
    def notify_submission(submission)
      @submission = submission
      @custom_form = submission.custom_form
      @request_url = submission.request_url
      @time = submission.created_at || Time.current
      default_subject = I18n.t(
        'submission_mailer.notify_submission.default_subject',
        custom_form_name: @custom_form.name
        )
      subject = submission.fields['_subject'] || default_subject
      mail(
        to: @custom_form.target_email,
        subject: "[#{@custom_form.name}] #{subject}"
      )
    end
  end
end
