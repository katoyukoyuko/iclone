class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 保存の成功した場合の処理
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    if logged_in?
      @favorite = current_user.favorites
    end
    @user.image.cache!   
  end

  def edit
    unless current_user == @user
      redirect_to user_path, notice: 'ほかのユーザーの投稿は編集できません'
    end
  end

  def update
      if @user.update(user_params)
        redirect_to user_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image, :image_chace)
  end
end
