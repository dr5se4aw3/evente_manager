class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_event_host, only: [:edit,:update,:destroy]
  before_action :authenticate_user!
  def index
    @events = Event.where(release: true)
  end

  def show
    @participant = current_user.event_participants.find_by(event_id: @event.id)
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(
        :title,
        :started_at,
        :closed_at,
        :venue_name,
        :venue_address,
        :venue_url,
        :event_image,
        :event_image_cache,
        :note,
        :release
        )
    end

    def check_event_host
      if current_user.id != @event.user_id
        redirect_to event_path(@event), notice: "イベントの編集・削除は運営者のみが可能です。"
      end
    end
end
