class AddRetweetCountToRetweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :retweets_count, :integer, null: false, default: 0
  end
end
