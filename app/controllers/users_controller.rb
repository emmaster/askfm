class UsersController < ApplicationController

  before_action :load_user, except: [:new,:create,:index]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def destroy
    if current_user == @user
      session[:user_id] = nil
      @user.destroy
      redirect_to root_url, alert: 'пользователь удален'
    else
      redirect_to root_url, alert: 'некого удалять'
    end
  end

  def create

    redirect_to root_url, alert: 'вы уже залогинены' if current_user.present?
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Пользователь успешно создан'
    else
      render 'new'
    end
  end

  def update

    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Пользователь успешно обновлен'
    else
      render 'edit'
    end
  end

  def edit
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count-@answers_count
  end

  private

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username,:avatar_url, :color)
  end

  def authorize_user
    reject_user unless @user == current_user
  end

end
