class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  #эта конструкция делает наш метод ниже доступным во всех
  #вьюхах приложения

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    #этот метод позволяет нам находить данного пользователя
    #и уже далее проходить разные проверки
  end

  def reject_user
    redirect_to root_url, alert: 'Вам сюда низя!'
  end

end
