class EventsController < ApplicationController
  # before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    # Loads all events and their associated users (eager loading for efficiency)
    # @events = policy_scope(Event.includes(:user))
    @events = Event.all  # simplified after removing Pundit

    respond_to do |format|
      format.html # renders the default index.html.erb
      # returning clean JSON for React frontend
      format.json { render json: @events }
    end
  end

  # GET /events/1 or /events/1.json
  def show
    # authorize @event  # removed Pundit

    respond_to do |format|
      format.html # renders the default show.html.erb
      # sending JSON data to React
      format.json { render json: @event }
    end
  end

  # GET /events/new
  def new
    @event = Event.new
    # authorize @event  # removed Pundit
  end

  # GET /events/1/edit
  def edit
    # authorize @event  # removed Pundit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        # returning full event record so React can update instantly
        format.json { render json: @event, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated.", status: :see_other }
        # sending updated JSON for React
        format.json { render json: @event, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    # authorize @event  # removed Pundit
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, notice: "Event was successfully destroyed.", status: :see_other }
      # React expects a clean status code for DELETE
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def event_params
      params.require(:event).permit(:title, :description, :location, :date, :time, :capacity)
    end
end
