class TropoSessionsController < ApplicationController
  def create
    sessions_object = Tropo::Generator.parse request.env['rack.input'].read
    number_to_dial = sessions_object[:session][:parameters][:number_to_dial]
    require 'pp'
    pp sessions_object.inspect

    tropo = Tropo::Generator.new do
              call :to => 'tel:+1' + number_to_dial
              on :event => 'hangup', :next => '/tropo_sessions/hangup.json'
              on :event => 'continue', :next => '/tropo_sessions/start_recording.json'
              ask({ :name    => 'ready',
                    :attempts => 5,
                    :bargein => true,
                    :timeout => 30,
                    :require => 'true' }) do
                      say     :value => 'Hello! Press 1 when your are ready to start crooning.'
                      choices :terminator => '1'
                    end
              end
    render :json => tropo.response
  end
end
