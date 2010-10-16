class TropoSessionsController < ApplicationController
  def create
    tropo = Tropo::Generator.new do
              call :to => "+14846787619"
              on :event => 'hangup', :next => '/tropo_sessions/hangup.json'
              on :event => 'continue', :next => '/tropo_sessions/start_recording.json'
              ask({ :name    => 'ready',
                    :attempts => 5,
                    :bargein => true,
                    :timeout => 30,
                    :require => 'true' }) do
                      say     :value => 'Hello! Press 1 when your are ready to start crooning.'
                      choices :value => 1
                    end
              end
    render :json => tropo.response
  end
end
