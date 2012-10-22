class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def list_sort_order(sort_order)
    search_order = sort_order || session[:search_order]
    case search_order
      when "a"
        session[:search_order] = "a"
        @mylists = List.where(["user_id = ?", current_user.id]).order("name ASC")
      when "z"
        session[:search_order] = "z"
        @mylists = List.where(["user_id = ?", current_user.id]).order("name DESC")
      when "0"
        session[:search_order] = "0"
        @mylists =  List.where(["user_id = ?", current_user.id]).order("created_at DESC")
      when "9"
        session[:search_order] = "9"
        @mylists =  List.where(["user_id = ?", current_user.id]).order("created_at ASC")
      else
        session[:search_order] = "a"
        @mylists = List.where(["user_id = ?", current_user.id]).order("name ASC")
    end
  end



  private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end


end
