FactoryBot.define do
  factory :submission, class: 'DynamicForms::Submission'do
    association :custom_form
    fields { {name: 'John', email: 'custom@mail.com', _subject: 'Test email'} }
    request_url {'website.com'}
  end
end
