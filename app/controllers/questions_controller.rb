class QuestionsController < ApplicationController
  before_action :set_question_for_current_user, only: %i[update destroy edit hide]
  before_action :ensure_current_user, only: %i[update destroy edit]

  def create
    question_params = params.require(:question).permit(:body, :user_id)

    @question = Question.new(question_params)

    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user), notice: 'Новый вопрос создан!'
    else
      flash[:alert] = 'Вопрос оформлен неверно!'

      redirect_to request.referrer
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Сохранили вопрос!'
    else
      flash.now[:alert] = 'Вопрос оформлен неверно!'

      render :update
    end
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
    @questions = Question.where(hidden: false).order(created_at: :desc).last(10)
    @users = User.order(created_at: :desc).last(10)
  end

  def new
    @user = User.friendly.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def edit; end

  def hide
    @question.toggle!(:hidden)

    redirect_to user_path(@question.user)
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
