class ListsController < ApplicationController
  def index
    @lists = List.all
    @articles = Article.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.image.attach(params[:list][:image]) if params[:list][:image].present?

    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :image)
  end
end
