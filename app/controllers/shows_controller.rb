class ShowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie

  def index
    @shows = @movie.shows
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
