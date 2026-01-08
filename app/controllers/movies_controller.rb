class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @shows = @movie.shows
  end
end
