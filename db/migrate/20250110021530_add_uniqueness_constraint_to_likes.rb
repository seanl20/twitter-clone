class AddUniquenessConstraintToLikes < ActiveRecord::Migration[7.2]
  def change
    add_index :likes, [ :user_id, :tweet_id ], unique: true
  end
end
