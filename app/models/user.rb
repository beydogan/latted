class User < ActiveRecord::Base
  before_save :default_values
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :login
  # attr_accessible :title, :body

  ## FOLLOWING AND FOLLOWERS
  has_many :items
  has_many :comments

  has_many :followings, :foreign_key => "follower_id",
           :dependent => :destroy
  has_many :followed_users, :through => :followings, :source => :followed

  has_many :reverse_relationships, :foreign_key => "followed_id",
           :class_name => "Following",
           :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  ## LIKES
  has_many :user_actions
  has_many :actions, :through => :user_actions, :source => :item



  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def following?(followed)
    followings.find_by_followed_id(followed)
  end

  def follow!(followed_id)
    followings.create!(:followed_id => followed_id)
  end

  def unfollow!(followed)
    followings.find_by_followed_id(followed).destroy
  end


  def method_missing(method_id, *arguments)
    if match = /([_a-zA-Z]\w*)_it/.match(method_id.to_s)
      action_name = match[1]
      action_type = UserActionType.find_by_name(action_name)
      action = action_type.user_actions.new
      action.user = self
      action.item = arguments[0]
      action_type.save
      action.save
      self.increment(action_name + "s")
      self.save
    elsif match = /my_([_a-zA-Z]\w*)s/.match(method_id.to_s)
      action_name = match[1]

      user_actions.joins('LEFT JOIN user_action_types ON user_action_types.id = user_actions.user_action_type_id').where('user_action_types.name = "'+ action_name +'"').collect{|a| a.item }
    else
      super
    end
  end


  def default_values
    self.wants ||= 0
    self.likes ||= 0
    self.owns ||= 0
    self.followers ||= 0
    self.follows ||= 0
  end

  def display_name
    self.username
  end
end
