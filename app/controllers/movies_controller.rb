class MoviesController < ApplicationController
  before_action :authtouser
  def new
    @movie = Movie.new
  end
  def index
    # byebug
    @movies = Movie.all
  end
  def show
    # byebug
    @movie = Movie.find(params[:id])
    @shows = @movie.shows
  end

  def create
    # byebug
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "Movie added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @movie = Movie.find_by(id:params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie details were successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find_by(id:params[:id])
    if @movie.destroy
      redirect_to movies_path, notice: "Movie deleted successfully"
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :duration, :banner_image)
  end
end
