class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :surname
      t.string :facebook_id
      t.string :twitter_id
      t.text   :description
      t.string :avatar_url
      t.string :displayname
      t.string :website
      t.string :auth_token
      t.string :password_reset_token
      t.timestamp :password_reset_sent_at
      t.timestamp :last_logged_in


      t.timestamps
    end
  end
end

