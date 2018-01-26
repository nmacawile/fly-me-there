class FlightsController < ApplicationController
  
  def index
    @flights = Flight.with_enough_seats_for(params[:seats])
                     .paginate(page: params[:page], per_page: 10)
                     .search_departure(params[:depart])
                     .search_route(params[:origin], params[:destination])
    @options = Airport.list
  end
end
