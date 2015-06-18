class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:login][:email])

    if user && user.authenticate(params[:login][:password])
      flash[:notice] = "You have successfully logged in!" 
      session[:user_id] = user.id.to_s
      flash[:notice] = "Hi #{current_user.first_name}! You have successfully logged in."
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Please try again!"
      render :new
    end
  end

  def destroy
    flash[:notice] = "You have successfully logged out!"
    session.delete(:user_id)
    "You have successfully logout."
    redirect_to login_path
  end
end
