class TropoRecordingsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    @croon = Croon.criteria.id(params[:croon_id]).first
    @croon.recording = params[:filename]
    @croon.status = "complete"
    if @croon.save
      render :json => {:success => true}.to_json
    else
      render :json => {:success => false}.to_json
    end
  end

end
