class ShowsController < ApplicationController
  before_action :authtouser
  before_action :set_movie
  before_action :set_show, only: [:edit, :update, :destroy]

  def new
    @show = @movie.shows.new
  end

  def create
    @show = @movie.shows.new(show_params)
    @show.total_seats = @show.available_seats

    if @show.save
      redirect_to movie_path(@movie), notice: "Show created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @show.update(show_params)
      redirect_to movie_path(@movie),
                  notice: "Show details were successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @show.destroy
    redirect_to movie_path(@movie),
                notice: "Show deleted successfully"
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_show
    @show = @movie.shows.find(params[:id])
  end

  def show_params
    params.require(:show).permit(:show_time, :available_seats, :seat_price)
  end
end
