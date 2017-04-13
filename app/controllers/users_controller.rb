class UsersController < ApplicationController
  def new
    @user = User.new
    @user.attachments.build
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_attachments_path user.id
    else
      redirect_to '/signup'
    end
  end

  def update
    user = User.find(params[:id])
    if user.attachments.create user_attachment_params
      redirect_to user_attachments_path user.id, status: 200
    else
      redirect_to user_attachments_path user.id, status: 400
    end
  end

  private
  def user_attachment_params
    params.require(:user).require(:attachment)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
