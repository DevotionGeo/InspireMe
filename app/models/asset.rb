class Asset < ActiveRecord::Base

  belongs_to :user
  belongs_to :list
  belongs_to :idea

  has_attached_file :asset, :styles => {:medium => "300x300>", :thumb => '100x100>'}

  def self.gather_logo_for_list(list)
    find_all_by_list_id(list)
  end
  def self.gather_images_for_idea(idea)
    find_all_by_idea_id(idea)
  end

  def self.gather_current_user_profile(user)
    find_all_by_user_id(user)
  end

end
