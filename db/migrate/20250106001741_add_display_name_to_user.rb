class AddDisplayNameToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :display_name, :string

    query = <<~SQL
      update users
      set display_name = username
      where display_name is null
    SQL

    ActiveRecord::Base.connection.execute(query)
  end
end
