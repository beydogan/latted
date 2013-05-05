class AddThumbToItem < ActiveRecord::Migration
  def change
    add_column :items, :thumb_id, :integer
  end
end
