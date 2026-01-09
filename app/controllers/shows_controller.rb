class ShowsController < ApplicationController
  before_action :authtouser
  before_action :movie
  def index
    @shows = @movie.shows
  end

  private

  def movie
    @movie = Movie.find(params[:movie_id])
  end
end
