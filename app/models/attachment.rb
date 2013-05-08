class Attachment < ActiveRecord::Base
  attr_accessible :description, :title, :version, :attachable_id, :attachable_type, :attach
  has_attached_file :attach, :styles => Sociality::Application::ITEM_IMAGE_SIZES

  belongs_to :item, :foreign_key => "attachable_id"
end
