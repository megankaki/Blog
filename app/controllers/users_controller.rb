class UsersController < ApplicationController
  def index
    @users = User.all.order("created_at DESC")
  end

  def new
    @user = User.new
  end
  
  def show  
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account successfully created."
      session[:user_id] = @user.id.to_s
      redirect_to users_path
    else
      flash.now[:error] = "Could not save account. Fill all fields."
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:notice] = "Account successfully updated."
      redirect_to user_path(@user)
    else 
      render :edit_user
    end
  end

  def destroy
    @user = User.find(params[:id])
    
    @user.destroy
    flash[:notice] = "Account successfully deleted."
    redirect_to users_path
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :image)
  end

end