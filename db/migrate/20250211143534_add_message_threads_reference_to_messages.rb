class AddMessageThreadsReferenceToMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :messages, :message_thread, null: false, foreign_key: true
  end
end
