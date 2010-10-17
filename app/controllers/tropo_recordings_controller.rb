class TropoRecordingsController < ApplicationController
  def create
    @croon = Croon.criteria.id(params[:croon_id]).first
    @croon.recording = params[:filename]
    if @croon.save!
      render :json => {:success => true}.to_json
    else
      render :json => {:success => false}.to_json
    end
  end

end
