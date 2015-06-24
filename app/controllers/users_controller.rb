class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]

  def show
    @user = User.find(params[:id])

    questions = Array.new

    @user.points.each do |point|
      unless questions.include?(point.question)
        questions << point.question
      end
    end
    @user.answers.each do |answer|
      unless questions.include?(answer.question)
        questions << answer.question
      end
    end

    @questions_answered = questions


  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        # sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  def test
    respond_to do |format|
      format.json { head :no_content }
    end

  end

  def update_activities_last_viewed
      logger.debug "This is from debug"

    current_user.update_activities_last_viewed
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end

end
