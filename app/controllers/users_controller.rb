class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @participate_events = current_user.participate_events
    @host_events = current_user.events
  end
end
host_events = User.first.events
