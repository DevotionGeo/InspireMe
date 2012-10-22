class ListingsController < ApplicationController
  def create
    @listing = current_user.listings.build(:list_id => params[:id])
    if @listing.save
      flash[:notice] = "Following list."
      redirect_to list_path(:id => @listing.list.name)
    else
      flash[:error] = "Unable to follow list."
      redirect_to list_path(:id => @listing.list.name)
    end
  end

  def destroy
  end

end
