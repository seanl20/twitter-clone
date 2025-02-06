class CreateHashtags < ActiveRecord::Migration[7.2]
  def change
    create_table :hashtags do |t|
      t.string :tag

      t.timestamps
    end
  end
end
