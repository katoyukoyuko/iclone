class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) # メールアドレスとパスワードが有効だった場合
      # ログイン成功した場合
      session[:user_id] = user.id # sessionメソッドを利用してログインを行う
      redirect_to user_path(user.id) # ユーザ詳細ページにリダイレクトさせる
    else
     flash.now[:danger] = 'ログインに失敗しました'
     render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
