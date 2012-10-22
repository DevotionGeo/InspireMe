class Listing < ActiveRecord::Base

  belongs_to :user
  belongs_to :list


  def self.followers(list)
    where("list_id = ?", list)
  end

end
