class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :surname, :description, :facebook_id, :twitter_id, :avatar_url, :website, :displayname, :assets_attributes
  has_secure_password
  has_many :lists
  has_many :assets

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :listings
  has_many :lists, :through => :listings


  accepts_nested_attributes_for :assets, :allow_destroy => true

  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => "create"
  validates_uniqueness_of :email, :on => "create", :message => "is already in use."
  validates_presence_of :displayname, :on => "create"
  validates_uniqueness_of :displayname, :on => "create", :message => "is already taken."

  before_create {generate_token(:auth_token)}

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def self.gather_friends_friend_details(friend)
    find_by_id(friend)
  end

end
