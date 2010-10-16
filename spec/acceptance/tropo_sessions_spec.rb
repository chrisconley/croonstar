require File.dirname(__FILE__) + '/acceptance_helper'

feature "Tropo Sessions", %q{
  In order to ...
  As a ...
  I want to ...
} do

  background do
    Croon.delete_all
    @croon = Factory(:croon)
  end

  scenario "TropoSessions#create.json" do
    Tropo::Generator.stub!(:parse).and_return({:session=>{:parameters=>{:croon_id=>@croon.id.to_s}}})

    page.driver.post '/tropo_sessions/create.json'

    page.should have_content(@croon.id.to_s)
    page.should have_content('Hello! Press 1 when your are ready to start crooning.')
    page.should have_content('ready')
    page.should have_content("/tropo_sessions/start_recording.json?croon_id=#{@croon.id}")
    page.should have_content("/tropo_sessions/hangup.json?croon_id=#{@croon.id}")
  end

  scenario "TropoSessions#start_recording.json" do
    page.driver.post "/tropo_sessions/start_recording.json?croon_id=#{@croon.id}"

    page.should have_content(@croon.song_url)
    page.should have_content("/tropo_recordings/create.json?croon_id=#{@croon.id}")
    page.should have_content("/tropo_sessions/processing.json?croon_id=#{@croon.id}")
  end
end

#Example Session object sent by Tropo
#{"session"=>{"timestamp"=>"2010-10-16T18:19:56.542Z", "parameters"=>{"token"=>"b271522390e9344386bab43e7c786b81ccff6ce46213d49c6efb629f74b1af5b80db554cecaeaf0b4d218e2a", "action"=>"create", "number_to_dial"=>"4846787619"}, "callId"=>nil, "userType"=>"NONE", "id"=>"e7c1f8c3328b5785df4cea8d90a2f3ab", "initialText"=>nil, "accountId"=>"50694"}}