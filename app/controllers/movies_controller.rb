class MoviesController < ApplicationController
  before_action :authtouser
  def new
    @movie = Movie.new
  end
  def index
    @movies = Movie.all
  end
  def show
    @movie = Movie.find(params[:id])
    @shows = @movie.shows
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "Movie added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :duration, :banner_image)
  end
end
