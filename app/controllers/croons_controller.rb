class CroonsController < ApplicationController
  def index
    @songs = Song.all
    @croons = Croon.all.order_by(:time_stamps.desc)
    @croon = Croon.new
  end

  def create
    @croon = Croon.new(params[:croon])
    if @croon.save
      AwesomeHTTP.get("http://api.tropo.com/1.0/sessions?action=create&token=b271522390e9344386bab43e7c786b81ccff6ce46213d49c6efb629f74b1af5b80db554cecaeaf0b4d218e2a", :croon_id => @croon.id)
      redirect_to croon_url(@croon)
    else
      @songs = Song.all
      @croons = Croon.all
      render :index
    end
  end

  def crooning
  end

  def show
    @croon = Croon.criteria.id(params[:id]).first
  end

  def listen

  end

end
