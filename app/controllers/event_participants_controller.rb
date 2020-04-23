class EventParticipantsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @participants = current_user.participate_events
  end
  def show
    @participants = EventParticipant.where(event_id: @current_event)
  end

  def create
    current_user.event_participants.create(event_id: params[:event_id])
    redirect_to events_url, notice: "イベントに参加しました"
  end

  def destroy
    current_user.event_participants.find_by(id: params[:id]).destroy
    redirect_to events_url, notice: "イベントの参加を取り消しました"
  end
end
