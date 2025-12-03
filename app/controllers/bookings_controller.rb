class BookingsController < ApplicationController
  # before_action :authenticate_user!   # removed Devise
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings or /bookings.json
  # Displays all bookings (for admin or listing view)
  def index
    @bookings = Booking.all
    render json: @bookings
  end

  # GET /bookings/1 or /bookings/1.json
  def show
    render json: @booking
  end

  # GET /bookings/new
  # Displays the form to create a new booking
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  # Displays the form to edit an existing booking
  def edit
  end

  # POST /bookings or /bookings.json
  # Handles creation of a new booking record
  def create
    @booking = Booking.new(booking_params)

    # manually assigning demo user since Devise was removed
    @booking.user = User.find_or_create_by(id: 1) do |u|
      u.name = "Demo User"
      u.email = "demo@example.com"   # following labs for seed style fallback
    end

    if @booking.save
      render json: @booking, status: :created
    else
      # this took me a while to fix — Rails returns structured errors here
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  # Updates existing booking data
  def update
    # authorize @booking   # removed Pundit

    if @booking.update(booking_params)
      render json: @booking, status: :ok
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  # Deletes a booking record
  def destroy
    # authorize @booking   # removed Pundit
    @booking.destroy!

    head :no_content  # React expects this
  end

  private

    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    # user_id is NOT permitted from the form (security)
    # React sends user_id manually but we override it anyway for safety
    def booking_params
      params.require(:booking).permit(:event_id, :status)
    end
end
