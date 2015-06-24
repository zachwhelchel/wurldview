class Answer < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	has_many :points

  after_create :record_create_activity
  after_update :record_update_activity

  def record_create_activity
    user.create_activity(self, 'created')
  end

  def record_update_activity
    user.create_activity(self, 'updated')
  end

end
