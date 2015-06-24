class UserFollow < ActiveRecord::Base
	belongs_to :user
	belongs_to :followed_user, class_name: 'User', foreign_key: 'followed_user_id'

	def send_following_email
		UserNotifier.user_followed(id).deliver
	end
end
