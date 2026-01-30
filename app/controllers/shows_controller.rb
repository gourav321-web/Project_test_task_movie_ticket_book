class ShowsController < ApplicationController
  before_action :authtouser
  before_action :set_movie
  before_action :set_show, only: [:edit, :update, :destroy]

  def new
    # byebug
    @show = @movie.shows.new
  end

  def create
    @show = @movie.shows.new(show_params)
    @show.total_seats = @show.available_seats
    byebug
    if @show.save
      byebug
      redirect_to movie_path(@movie), notice: "Show created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    byebug
    @show.total_seats = @show.available_seats
    if @show.update(show_params)
      redirect_to movie_path(@movie),notice: "Show details were successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    byebug
    @show.destroy
    redirect_to movie_path(@movie), notice: "Show deleted successfully"
  end

  def search_show
    @movie = Movie.find(params[:movie_id])
    @shows = @movie.shows.where("show_time >= ?", Time.current)

    if params[:date].present? && params[:time].present?
      selected_datetime = DateTime.parse("#{params[:date]} #{params[:time]}")
      @shows = @shows.where(show_time: selected_datetime)

    elsif params[:date].present?
      selected_date = Date.parse(params[:date])
      @shows = @shows.where(show_time: selected_date.all_day)

    elsif params[:time].present?
      @shows = @shows.where("TIME(show_time) >= ?", params[:time])

    else
      flash.now[:notice] = "Please select date or time"
    end
  end

  def import_show
    Show.import_from_csv(@movie[:id])
    redirect_to movie_path(@movie), notice: "Shows imported successfully!"
    rescue StandardError => e
      byebug
    redirect_to movie_path(@movie), alert: "Import failed: #{e.message}"
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
