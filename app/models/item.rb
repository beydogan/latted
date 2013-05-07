class Item < ActiveRecord::Base
  attr_accessible :content, :item_category_id, :link, :store_id, :title, :user_id, :attachments_attributes

  has_many :attachments, :foreign_key => "attachable_id"
  accepts_nested_attributes_for :attachments

  has_many :user_actions
  has_many :actioned, :through => :user_actions, :source => :user

  belongs_to :item_category
  belongs_to :user

  def thumb
    attachments.find_by_id(self.thumb_id)
  end

  def thumb_url
    t = self.thumb
    if t
      t
    else
      self.attachments.empty? ? "http://placehold.it/72x72" : self.attachments.first.attach.url(:small)
    end
  end

  def method_missing(method_id, *arguments)
    if match = /who_([_a-zA-Z]\w*)s/.match(method_id.to_s)
      action_name = match[1]
      user_actions.joins('LEFT JOIN user_action_types ON user_action_types.id = user_actions.user_action_type_id').where('user_action_types.name = "'+ action_name +'"').collect{|a| a.item }
    else
      super
    end
  end
end
