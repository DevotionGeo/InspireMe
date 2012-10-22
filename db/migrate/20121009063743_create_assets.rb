class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :user_id
      t.integer :list_id
      t.integer :idea_id

      t.timestamps
    end
  end
end
