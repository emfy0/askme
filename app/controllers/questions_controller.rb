class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update show destroy edit]

  def create
    question_params = params.require(:question).permit(:body, :user_id)

    @question = Question.create(question_params)

    redirect_to user_path(@question.user), notice: 'Новый вопрос создан!'
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    @question.update(question_params)

    redirect_to user_path(@question.user), notice: 'Сохранили вопрос!'
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user), notice: 'Вопрос удалён!'
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @question = Question.new
    @questions = Question.all
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def edit
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question
    @question = current_user.questions.find(params[:id])
  end
end
