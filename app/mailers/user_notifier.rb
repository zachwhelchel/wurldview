class UserNotifier < ActionMailer::Base
  default from: "from@example.com"

  def user_followed(user_follow_id)

  	user_follow = UserFollow.find(user_follow_id)

  	@user = user_follow.user
  	@user_followed = user_follow.followed_user

  	mail to: @user_followed.email,
  			 subject: "#{@user.email} followed you on Wurldview."
  end
end
