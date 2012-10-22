class FriendshipsController < ApplicationController

  def index
    list_sort_order(params[:so])
    @allusers = User.all
  end

  def new
    list_sort_order(params[:so])
    @allusers = User.where("id != ?", current_user.id)
  end

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to root_url
  end


end
