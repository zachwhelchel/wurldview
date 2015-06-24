class Activity < ActiveRecord::Base
	belongs_to :user
	belongs_to :targetable, polymorphic: true

	def self.for_user(user, options={})
		followed_user_ids = user.followed_users.map(&:id)
		activities = where("user_id in (?)", followed_user_ids).order("created_at desc").all
		if options[:current_user_id_for_since] && !options[:current_user_id_for_since].blank?
			current_user = User.find(options[:current_user_id_for_since])
			if (current_user.activities_last_viewed)
				activities = activities.where("created_at > ?", current_user.activities_last_viewed) if current_user
			end
		end
		activities
	end

end
