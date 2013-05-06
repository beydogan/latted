class Item < ActiveRecord::Base
  attr_accessible :content, :item_category_id, :link, :store_id, :title, :user_id, :attachments_attributes

  has_many :attachments, :foreign_key => "attachable_id"
  accepts_nested_attributes_for :attachments

  has_many :user_actions
  has_many :actioned, :through => :user_actions, :source => :user

  belongs_to :item_category

  def thumb
    attachments.find_by_id(self.thumb_id)
  end
end
