class ItemCategory < ActiveRecord::Base
  attr_accessible :title

  has_and_belongs_to_many :items, join_table: "items_item_categories"
end
