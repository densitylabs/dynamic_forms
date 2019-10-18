# this code is based on http://www.candland.net/2012/04/17/rails-routes-used-in-an-isolated-engine/
module DynamicForms
  module CustomFormsHelper
    def is_active?(value)
      value ? 'active' : 'inactive'
    end

    def default_json_schema
      return @custom_form.json_schema if @custom_form&.json_schema

      {
        "title": "Contact us",
        "description": "A simple contact us ",
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
      }.to_json
    end

    def default_ui_schema
      return @custom_form.ui_schema if @custom_form&.ui_schema

      {
        "name": {
          "ui:autofocus": true,
          "ui:title": "First and Last Name",
          "ui:emptyValue": ""
        },
        "company": {
          "ui:help": "This field could be empty"
        },
        "message": {
          "ui:widget": "textarea",
          "ui:description": "Write here what you want to tell us"
        }
      }.to_json
    end
  end
end
