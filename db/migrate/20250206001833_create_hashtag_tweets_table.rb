class CreateHashtagTweetsTable < ActiveRecord::Migration[7.2]
  def change
    create_table :hashtags_tweets, id: false do |t|
      t.belongs_to :hashtag
      t.belongs_to :tweet

      t.timestamps
    end
  end
end
