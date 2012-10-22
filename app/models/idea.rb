class Idea < ActiveRecord::Base

  attr_accessible :title, :content, :list_id, :assets_attributes, :created_at

  belongs_to :list
  has_many :assets

  accepts_nested_attributes_for :assets, :allow_destroy => true

  validates_presence_of :title, :on => "create"
  validates_presence_of :content, :on => "create"
  validates_presence_of :list_id, :on => "create"

  def self.newcontent(user)
    where("updated_at > ?", user.last_logged_in)
  end

end
