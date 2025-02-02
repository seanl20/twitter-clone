class AddFollowingCountToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :following_count, :integer, null: false, default: 0
  end
end
