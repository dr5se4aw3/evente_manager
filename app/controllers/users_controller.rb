class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @events = (current_user.participate_events) + (current_user.events)

  end
end
