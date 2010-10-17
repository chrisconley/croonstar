class TropoSessionsController < ApplicationController
  before_filter :find_croon
  def create
    tropo = Tropo::Generator.new
    tropo.call :to => 'tel:+1' + @croon.phone_number
    tropo.on :event => "hangup", :next => "/tropo_sessions/hangup.json?croon_id=#{@croon.id}"
    tropo.on :event => "continue", :next => "/tropo_sessions/start_recording.json?croon_id=#{@croon.id}"
    tropo.ask({
      :name    => 'ready',
      :attempts => 5,
      :bargein => true,
      :timeout => 30,
      :require => 'true' }) do
        say     :value => 'Hello! Press 1 when your are ready to start crooning.'
        choices :terminator => '1'
    end

    render :json => tropo.response
  end

  def start_recording
    tropo = Tropo::Generator.new
    tropo.on :event => "hangup", :next => "/tropo_sessions/processing.json?croon_id=#{@croon.id}"
    tropo.on :event => "continue", :next => "/tropo_sessions/processing.json?croon_id=#{@croon.id}"
    tropo.start_recording :url => "http://web1.tunnlr.com:9901/tropo_recordings/create.json?croon_id=#{@croon.id}", :format => "mp3"
    tropo.say @croon.song_url

    render :json => tropo.response
  end

  private

  def find_croon
    croon_id = begin
      sessions_object = Tropo::Generator.parse request.env['rack.input'].read
      sessions_object[:session][:parameters][:croon_id]
    rescue
      params[:croon_id]
    end
    @croon = Croon.criteria.id(croon_id).first
  end
end
