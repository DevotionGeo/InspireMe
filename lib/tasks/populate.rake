namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    [User, List, Idea, Listing, Asset, Friendship].each(&:delete_all)
    require 'rubygems'
    require 'active_support'
    require 'faker'

    %w[alice bob charlie david edward fred gary harry ian jon keith len mark neil oliver peter roger steve].each do |person|
      # create users
      curr_user = User.create(
          :displayname => person,
          :email => person + "@test.com",
          :password => "test",
          :password_confirmation => "test"
          )
          #add several lists to each user
          li = rand(7-1)+3
          li.times do |l|
          this_list = List.create(
              :name => Faker::Lorem.word,
              :description => Faker::Lorem.sentence,
              :private => 0,
              :user_id => curr_user.id
              )
              #add several ideas to each list
              ide = rand(7-1)+3
              createdat = this_list.created_at
              ide.times do |a|
                this_idea = Idea.create(
                    :title => Faker::Lorem.word,
                    :content => Faker::Lorem.sentence,
                    :list_id => this_list.id
                )
              end
          end
    end
  end
end