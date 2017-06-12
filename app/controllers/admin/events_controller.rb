class Admin::EventsController < ApplicationController
  include Paginatable
  #  before_action :authenticate_admin_admin!, except: [:create]
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    events = Event
      .joins('left outer join (select event_id, count(1) volunteer_count from events_volunteers group by event_id) e_v on e_v.event_id = events.id')
      .select('events.id, events.title, events.description, coalesce(e_v.volunteer_count, 0) as volunteer_count, events.start_date, events.end_date')
      .order(start_date: :desc)
      .page(params[:page])

    render json: events, admin: true, meta: paginate(events)
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created
    else
      render json: { status: 'error', errors: @event.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: { status: 'error', errors: @event.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    render status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_params
    params.fetch(:event, {}).permit(:title, :description, :start_date, :end_date)
  end
end
