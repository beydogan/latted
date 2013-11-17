class CreateWatchedItems < ActiveRecord::Migration
  def change
    create_table :watched_items, id: false do |t|
      t.integer :user_id
      t.integer :item_id

    end

    add_index :watched_items, [:user_id, :item_id]

  end
end
