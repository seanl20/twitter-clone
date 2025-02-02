class ChangeUserUrlToProfileUrl < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :url, :profile_url
  end
end
