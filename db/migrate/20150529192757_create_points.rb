class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :title
      t.integer :question_id
      t.timestamps
    end
  end
end
