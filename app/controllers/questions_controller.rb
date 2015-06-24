class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    if params[:user_id]
      @user_filtered_to = User.find(params[:user_id])
    else
      if signed_in?
        @user_filtered_to = current_user
      end
    end
    if params[:question_id_from]
      @question_from = Question.find(params[:question_id_from])
    end


    respond_with(@question)
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    @question.save
    respond_with(@question)
  end

  def update
    @question.update(question_params)
    respond_with(@question)
  end

  def destroy
    @question.destroy
    respond_with(@question)
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      # REVIEW - Not sure this is the safest way.
      params.require(:question).permit(:user_id, :title, points_attributes: [:id, :_destroy, :title, :answer_id, :user_id], answers_attributes: [:id, :_destroy, :title, :user_id])
    end
end
