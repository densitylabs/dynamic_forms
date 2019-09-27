class CreateDynamicFormsCustomForms < ActiveRecord::Migration[5.1]
  def change
    create_table :dynamic_forms_custom_forms do |t|
      t.string :name
      t.boolean :enabled, default: true
      t.string :slug, unique: true, index: true
      t.string :restrict_domian
      t.string :target_email
      t.boolean :allow_notifications, default: true
      t.boolean :allow_recording_submissions, default: true
      t.timestamps
    end
  end
end
