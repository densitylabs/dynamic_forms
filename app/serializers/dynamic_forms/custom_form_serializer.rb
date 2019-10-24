module DynamicForms
  class CustomFormSerializer < ActiveModel::Serializer
    attributes :json_schema, :ui_schema

    def json_schema
      return {} unless object.json_schema_available?

      JSON.parse(object.json_schema)
    end

    def ui_schema
      return {} unless object.ui_schema_available?

      JSON.parse(object.ui_schema)
    end
  end
end
