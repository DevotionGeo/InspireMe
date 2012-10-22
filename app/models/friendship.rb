class Friendship < ActiveRecord::Base

  attr_accessible :user_id, :friend_id, :list_id

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def self.gather_friends(friendship)
    @this_user = friendship
    @user_friends = @this_user.friend_id
    where("user_id = ?", @user_friends)
  end
end
