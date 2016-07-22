class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      #re-render_to new view
    end
  end

  def show
    if current_user.nil? || current_user != user_path
      redirect_to new_user_path, alert: "Not authorized"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
