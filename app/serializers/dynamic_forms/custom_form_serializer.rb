module DynamicForms
  class CustomFormSerializer < ActiveModel::Serializer
    attributes :json_schema

    def json_schema
      JSON.parse(object.json_schema)
    end
  end
end
