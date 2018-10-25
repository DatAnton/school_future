class AddDefForm < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :form_id, :integer, :default => 1
  end
end
