class CreateDynamicFormsSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :dynamic_forms_submissions do |t|
      t.references :custom_form
      t.json :fields
      t.string :request_url
      t.timestamps
    end
  end
end
