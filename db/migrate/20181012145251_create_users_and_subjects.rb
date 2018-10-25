class CreateUsersAndSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :users_and_subjects do |t|
      t.integer :user_id
      t.integer :subject_id
      t.timestamps
    end
  end
end
