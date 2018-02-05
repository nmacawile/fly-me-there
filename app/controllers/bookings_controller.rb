class BookingsController < ApplicationController
  
  def show
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
  end
 
  def new
    @flight = Flight.find(params[:flight_id].to_i)
    @booking = Booking.new
    @seats = params[:seats].to_i
    if @seats < 1
      @seats = 1
    elsif @seats > 4
      @seats = 4
    end
    @seats.times { @booking.passengers.build }
  end
  
  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      flash[:success] = "You have successfully booked this flight."
      redirect_to @booking
    else
      @seats = params[:seats].present? ? /(\d)/.match(params[:seats]).captures.first.to_i : 1
      @flight = Flight.find(booking_params[:flight_id].to_i)
      render 'new'
    end
  end
  
  private
  
    def booking_params
      params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email, :booking_id])
    end
end
