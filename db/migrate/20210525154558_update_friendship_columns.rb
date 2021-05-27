class UpdateFriendshipColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :initiator_id, :integer
    add_index :friendships, %i[user_id friend_id], unique: true
  end
end
