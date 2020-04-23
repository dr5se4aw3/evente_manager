class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id), notice: '他ユーザーの情報は閲覧できません。'
    end
    @events = (current_user.participate_events) + (current_user.events)

  end
end
