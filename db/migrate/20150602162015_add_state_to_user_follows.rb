class AddStateToUserFollows < ActiveRecord::Migration
  def change
  	add_column :user_follows, :state, :string
  	add_index :user_follows, :state
  end
end
