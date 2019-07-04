class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.integer :grade
      t.integer :subject_id
      t.integer :user_id
      t.timestamps
    end
  end
end
