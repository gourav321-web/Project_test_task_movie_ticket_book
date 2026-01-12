class ShowsController < ApplicationController
  before_action :authtouser
  before_action :movie

  def new
    @movie = Movie.find(params[:movie_id])
    @show = @movie.shows.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @show = @movie.shows.new(show_params)

    if @show.save
      redirect_to movie_path(@movie), notice: "Show created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  def movie
    @movie = Movie.find(params[:movie_id])
  end

  def show_params
    params.require(:show).permit(:show_time, :available_seats, :seat_price)
  end
end
