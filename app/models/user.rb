class User < ActiveRecord::Base
  rolify

  devise :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable

  has_many :questions
  has_many :answers
  has_many :points
  has_many :user_follows
  has_many :followed_users, through: :user_follows
  has_many :activities
  has_many :identities

  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def update_activities_last_viewed
    self.update_column(:activities_last_viewed, Time.now)
  end

  def activities_count
    Activity.for_user(self, current_user_id_for_since: self.id).count
  end

  def user_follow_for_followed_user(followed_user)
    user_follows.each do |user_follow|
      if user_follow.followed_user == followed_user
        return user_follow
      end
    end
  end

  def create_activity(item, action)
    activity = activities.new
    activity.targetable = item
    activity.action = action
    activity.save
    activity
  end

  def email_verified?
    self.email.length > 0
  end

end
