class CreateMessageThreads < ActiveRecord::Migration[7.2]
  def change
    create_table :message_threads do |t|
      t.timestamps
    end
  end
end
