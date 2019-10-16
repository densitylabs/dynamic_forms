FactoryBot.define do
  factory :custom_form, class: 'DynamicForms::CustomForm' do
    name { 'Custom form' }

    trait :with_json_schema do
      is_schema_enabled { true }
      json_schema { {
        "title": "Contact us",
        "type": "object",
        "required": [
          "name"
        ],
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "email": {
            "type": "email",
            "title": "Email"
          },
          "_subject": {
            "type": "text",
            "title": "Subject"
          }
        }
      }.to_json }
    end
  end
end
