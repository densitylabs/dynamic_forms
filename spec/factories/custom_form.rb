FactoryBot.define do
  factory :custom_form, class: 'DynamicForms::CustomForm' do
    name { 'Custom form' }

    trait :with_json_schema do
      is_schema_enabled { true }
      json_schema { {
        "title": "Contact us",
        "description": "A simple contact us",
        "type": "object",
        "required": [
          "name",
          "email",
          "message"
        ],
        "additionalProperties": true,
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "email": {
            "type": "string",
            "title": "Email",
            "format": "email"
          },
          "company": {
            "type": "string",
            "title": "Company"
          },
          "message": {
            "type": "text",
            "title": "Message",
            "minLength": 10
          }
        }
      }.to_json }
    end
  end
end
