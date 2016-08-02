class AddUserIdToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :user_id, :integer
  end
end
