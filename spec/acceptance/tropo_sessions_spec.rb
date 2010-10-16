require File.dirname(__FILE__) + '/acceptance_helper'

feature "Tropo Sessions", %q{
  In order to ...
  As a ...
  I want to ...
} do

  scenario "TropoSessions#create.json" do
    page.driver.post '/tropo_sessions/create.json'

    page.should have_content('Hello! Press 1 when your are ready to start crooning.')
    page.should have_content('ready')
    page.should have_content('/tropo_sessions/start_recording.json')
    page.should have_content('/tropo_sessions/hangup.json')
  end
end
