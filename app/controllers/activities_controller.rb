class ActivitiesController < ApplicationController

	respond_to :html, :json

	def index
		@activities = Activity.for_user(current_user, params)
		respond_with @activities
	end
end
