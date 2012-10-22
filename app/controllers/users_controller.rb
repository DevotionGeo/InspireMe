class UsersController < ApplicationController
  layout 'user'
  def new
    @user = User.new
    1.times {@user.assets.build}
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice =>"Signed up"
    else
      render "new"
    end
  end

  def show
    @user = User.find_by_displayname(params[:id])
    @listings = Listing.find_all_by_user_id(params[:id])
  end

  def edit
    @user = User.find_by_displayname(current_user.displayname)
    @allusers = User.all
    @listings = Listing.find_all_by_user_id(current_user.id)
    1.times {@user.assets.build}
  end

  def update
    @user = User.find_by_displayname(current_user.displayname)

    if @user.update_attributes(params[:user])

       redirect_to home_path(:id => current_user.displayname), :notice => "Updated"
    else
      redirect_to home_path(:id => current_user.displayname), :alert => "Something went wrong, please try again"
    end
  end

  def destroy
    @user = User.find_by_displayname(current_user.displayname)
  end
end
