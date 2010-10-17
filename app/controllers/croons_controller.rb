class CroonsController < ApplicationController
  def index
    @songs_for_select = Song.select_options
    @croons = Croon.all
    @croon = Croon.new
  end

  def create
    @croon = Croon.new(params[:croon])
    if @croon.save
      AwesomeHTTP.get("http://api.tropo.com/1.0/sessions?action=create&token=b271522390e9344386bab43e7c786b81ccff6ce46213d49c6efb629f74b1af5b80db554cecaeaf0b4d218e2a", :croon_id => @croon.id)
      redirect_to croon_url(@croon)
    else
      @songs_for_select = Song.all.collect {|s| [ s.title, s.url ] }
      @croons = Croon.all
      render :index
    end
  end

  def crooning
  end

  def show
  end

  def listen

  end

end
