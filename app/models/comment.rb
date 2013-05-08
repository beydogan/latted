class Comment < ActiveRecord::Base
  attr_accessible :content, :item_id, :user_id

  belongs_to :user
  belongs_to :item
end
