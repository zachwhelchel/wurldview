class PointsController < ApplicationController
  before_action :set_question, only: [:new, :edit, :create, :index]
  before_action :set_point, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def create
    @point = @question.points.new(point_params.merge(user: current_user))
    @point.save
    respond_to do |format|
      format.html { redirect_to question_points_url }
      format.json { head :no_content }
    end
  end

  def update
    @point.update(point_params)
    respond_to do |format|
      format.html { redirect_to question_points_url }
      format.json { head :no_content }
    end
  end

  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to question_points_url }
      format.json { head :no_content }
    end
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_point
      @point = Point.find(params[:id])
    end

    def point_params
      params.require(:point).permit(:user_id, :title, :answer_id)
    end
end
