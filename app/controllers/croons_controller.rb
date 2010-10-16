class CroonsController < ApplicationController
  def index
    @songs_for_select = Song.all.collect {|s| [ s.title, s.url ] }
    @croons = Croon.all
    @croon = Croon.new
  end

  def create
    @croon = Croon.new(params[:croon])
    puts @croon
    if @croon.save

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
