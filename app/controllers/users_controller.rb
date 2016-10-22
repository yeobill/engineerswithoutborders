class UsersController < ApplicationController
  before_action only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
  end
  
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    user = User.find(params[:id])
    # Basic Information
    user.first_name = user_params[:first_name]
    user.last_name = user_params[:last_name]
    user.age = user_params[:age]
    user.education = user_params[:education]
    user.expertise = user_params[:expertise]
    user.save
    flash[:notice] = "Profile was successfully updated."
    redirect_to user_path(params[:id])
  end

  private
  def user_params
    params.require(:user)
  end    
end
