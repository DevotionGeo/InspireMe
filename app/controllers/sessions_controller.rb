class SessionsController < ApplicationController

  def new
  end
  def create
    user = User.find_by_displayname(params[:displayname])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      if current_user.displayname
        ns = current_user.displayname
      else
        ns = current_user.email
      end
      redirect_to home_path(:id => current_user.displayname), :notice => "Welcome " + ns + "!"
    else
      flash.now.alert = "Invalid credentials."
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "You have been logged out."
  end


end

