class CroonsController < ApplicationController
  def index
    @songs_for_select = Song.all.collect {|s| [ s.title, s.url ] }
    @croons = Croon.all
    @croon = Croon.new
  end

  def create
    p params[:croon]
    c = Croon.create(params[:croon])
    puts c
  end

  def crooning
  end

  def show
  end

  def listen
    
  end

end
