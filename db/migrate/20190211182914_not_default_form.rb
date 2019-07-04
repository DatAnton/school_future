class NotDefaultForm < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :form_id, nil
  end
end
