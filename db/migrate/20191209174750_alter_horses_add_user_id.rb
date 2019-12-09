class AlterHorsesAddUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :horses, :user_id, :integer
    add_index :horses, :user_id
  end
end
