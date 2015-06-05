class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:login][:email])

    if user && user.authenticate(params[:login][:password]) 
      session[:user_id] = user.id.to_s
      flash[:notice] = "You have successfully logged in."
      redirect_to user_path(current_user)
    else
      flash[:error] = "Failed to log in."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    "You have successfully logout."
    redirect_to login_path
  end
end
