require File.dirname(__FILE__) + '/acceptance_helper'

feature "Tropo Sessions", %q{
  In order to ...
  As a ...
  I want to ...
} do

  scenario "TropoSessions#create.json" do
    recording_id = '12345'
    Tropo::Generator.stub!(:parse).and_return({:session=>{:parameters=>{:recording_id=>recording_id}}})
    page.driver.post '/tropo_sessions/create.json'

    page.should have_content(recording_id)
    page.should have_content('Hello! Press 1 when your are ready to start crooning.')
    page.should have_content('ready')
    page.should have_content("/tropo_sessions/start_recording.json/?recording_id=#{recording_id}")
    page.should have_content("/tropo_sessions/hangup.json?recording_id=#{recording_id}")
  end
  
  scenario "TropoSessions#start_recording.json" do
    recording_id = '12345'
    recording = Recording.create(:id => recording_id, :song_url => "/test.mp3")
    Tropo::Generator.stub!(:parse).and_return({:session=>{:parameters=>{:recording_id=>recording_id}}})
    page.driver.post '/tropo_sessions/start_recording.json'

    page.should have_content(recording.song_url)
    page.should have_content("/tropo_mp3s/#{recording.id}")
    page.should have_content("/tropo_sessions/processing?#{recording.id}")
  end
end

#Example Session object sent by Tropo
#{"session"=>{"timestamp"=>"2010-10-16T18:19:56.542Z", "parameters"=>{"token"=>"b271522390e9344386bab43e7c786b81ccff6ce46213d49c6efb629f74b1af5b80db554cecaeaf0b4d218e2a", "action"=>"create", "number_to_dial"=>"4846787619"}, "callId"=>nil, "userType"=>"NONE", "id"=>"e7c1f8c3328b5785df4cea8d90a2f3ab", "initialText"=>nil, "accountId"=>"50694"}}