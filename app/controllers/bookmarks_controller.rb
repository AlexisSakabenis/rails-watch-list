class BookmarksController < ApplicationController
  include Rails.application.routes.url_helpers

  def create
    @list = List.find(params[:bookmark][:list_id])
    @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark = Bookmark.new(list: @list, movie: @movie, comment: params[:bookmark][:comment])
    if @bookmark.save
      redirect_to list_path(@list), notice: 'Bookmark was successfully created.'
    else
      redirect_to list_path(@list), alert: 'Failed to create bookmark.'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list), notice: 'Bookmark was successfully destroyed.'
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end
end
