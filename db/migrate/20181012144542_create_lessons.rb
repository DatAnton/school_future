class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.integer :number
      t.integer :day
      t.integer :subject_id
      t.integer :form_id
      t.timestamps
    end
  end
end
