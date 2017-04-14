class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all     #note that index is plural
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = Advertisement.new
    @advertisement.title = params[:advertisement][:title]
    @advertisement.copy = params[:advertisement][:copy]
    @advertisement.price = params[:advertisement][:price]

    if @advertisement.save
      flash[:notice] = "Advertisement saved."
      redirect_to @advertisement
    else
      flash[:error] = "An error occurred. Please try again."
      render :new
    end
  end
end
