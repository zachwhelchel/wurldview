class AnswersController < ApplicationController
  before_action :set_question, only: [:new, :edit, :create, :index]
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    @answer.save
    respond_to do |format|
      format.html { redirect_to question_answers_url }
      format.json { head :no_content }
    end
  end

  def update
    @answer.update(answer_params)
    respond_to do |format|
      format.html { redirect_to question_answers_url }
      format.json { head :no_content }
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question_answers_url }
      format.json { head :no_content }
    end
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:user_id, :title)
    end
end