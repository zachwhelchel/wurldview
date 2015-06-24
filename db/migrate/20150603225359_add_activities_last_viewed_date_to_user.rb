class AddActivitiesLastViewedDateToUser < ActiveRecord::Migration
  def change
  	add_column :users, :activities_last_viewed, :datetime
  end
end
