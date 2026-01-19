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
    @show.total_seats = @show.available_seats
    if @show.update(show_params)
      redirect_to movie_path(@movie),notice: "Show details were successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @show.destroy
    redirect_to movie_path(@movie), notice: "Show deleted successfully"
  end

  def search_show
    # byebug

    @movie = Movie.find(params[:movie_id])
    if params[:date].present?
      date_only = Date.parse(params[:date])
      # 2. Use a range to get all shows between 00:00:00 and 23:59:59
      @shows = @movie.shows.where(show_time: date_only.all_day)

    elsif params[:time].present?
      parsed_time = Time.parse(params[:time])
      datetime_object = params[:time].to_datetime
      byebug
      @shows = @movie.shows.where(show_time: datetime_object)

    else
      flash[:notice] = "Please select date or time"
      @shows = @movie.shows
    end

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
