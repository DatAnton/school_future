class CreateHomeworks < ActiveRecord::Migration[5.2]
  def change
    create_table :homeworks do |t|
      t.integer :lesson_id
      t.string :homework
      t.timestamps
    end
  end
end
