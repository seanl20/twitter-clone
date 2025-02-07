class AddIndexToTagColumnOnHashtags < ActiveRecord::Migration[7.2]
  def change
    add_index :hashtags, :tag
  end
end
