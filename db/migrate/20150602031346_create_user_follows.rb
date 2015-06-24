class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows do |t|

    	t.integer :user_id
    	t.integer :followed_user_id
      t.timestamps
    end

    add_index :user_follows, [:user_id, :followed_user_id]
  end
end
