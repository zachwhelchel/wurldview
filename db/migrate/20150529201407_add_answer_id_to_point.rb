class AddAnswerIdToPoint < ActiveRecord::Migration
  def change
  	add_column :points, :answer_id, :integer
  end
end
