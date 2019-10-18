class AddUiSchemaToCustomForm < ActiveRecord::Migration[5.1]
  def change
    add_column :dynamic_forms_custom_forms, :ui_schema, :json
    add_column :dynamic_forms_custom_forms, :is_ui_schema_enabled, :boolean, default: false
  end
end
