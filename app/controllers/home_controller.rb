class HomeController < ApplicationController
    def show
      list_sort_order(params[:so])
      @newlists = List.newcontent(current_user)
      @newideas = Idea.newcontent(current_user)
      @lastlogged = current_user.last_logged_in

      if @lastlogged.blank?
        current_user.last_logged_in = Time.zone.now
        current_user.save!
      else
        if @lastlogged < 1.day.ago
          current_user.last_logged_in = Time.zone.now
          current_user.save!
        end
      end
    end
end

