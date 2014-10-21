class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :load_user

  def load_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user
  end
end
