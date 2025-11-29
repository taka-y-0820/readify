class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    # ログインフォーム
  end
  
  def create
    user = User.find_by(email: params[:email].downcase.strip)
    
    if user&.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id
      redirect_to library_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end
