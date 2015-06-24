class UserFollowsController < ApplicationController
	before_filter :authenticate_user!, only: [:new]
	respond_to :html, :json


	def new
		if params[:followed_user_id]
			@followed_user = User.find(params[:followed_user_id]) 
			@user_follow = current_user.user_follows.new(followed_user: @followed_user)
		else
			flash[:error] = "Followed user required"
		end
	end

	def create
		if user_follow_params[:followed_user_id]
			@followed_user = User.find(user_follow_params[:followed_user_id]) 
			@user_follow = current_user.user_follows.new(followed_user: @followed_user)

			@user_follow.save

			respond_to do |format|
				format.html do
					redirect_to root_path
				end
				format.json { render json: @user_follow.to_json }
			end


		else
			flash[:error] = "Followed user required"
			redirect_to root_path
		end
	end

	def edit
		@user_follow = current_user.user_follows.find(params[:id])
	end

	def destroy
		@user_follow = current_user.user_follows.find(params[:id])
		@user_follow.destroy

			respond_to do |format|
				format.html do
					redirect_to root_path
				end
				format.json { }
			end
	end


	private
    def user_follow_params
      params.require(:user_follow).permit(:user, :followed_user, :user_id, :followed_user_id, :id)
    end

end
