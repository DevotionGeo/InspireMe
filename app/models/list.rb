class List < ActiveRecord::Base
  attr_accessible :name, :description, :private, :assets_attributes, :user_id, :created_at

  belongs_to :user
  has_many :ideas, :dependent => :destroy
  has_many :assets, :dependent => :destroy
  has_many :listings, :dependent => :destroy

  accepts_nested_attributes_for :assets, :allow_destroy => true

  validates_presence_of :name
  validates_presence_of :description

  def self.newcontent(user)
    where("updated_at > ?", user.last_logged_in)
  end



end
