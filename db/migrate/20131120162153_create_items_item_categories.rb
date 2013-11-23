class CreateItemsItemCategories < ActiveRecord::Migration
  def change
    create_table :items_item_categories do |t|
      t.integer :item_id
      t.integer :item_category_id
    end
  end
end
