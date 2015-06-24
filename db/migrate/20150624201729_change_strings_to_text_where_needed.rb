class ChangeStringsToTextWhereNeeded < ActiveRecord::Migration
  def change
			remove_column :answers, :title
  	  add_column :answers, :title, :text

			remove_column :points, :title
  	  add_column :points, :title, :text

			remove_column :questions, :title
  	  add_column :questions, :title, :text
  end
end
