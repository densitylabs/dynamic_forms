class AddJsonSchemaToCustomForms < ActiveRecord::Migration[5.1]
  def change
    add_column :dynamic_forms_custom_forms, :json_schema, :json
    add_column :dynamic_forms_custom_forms, :is_schema_enabled, :boolean, default: false
  end
end
