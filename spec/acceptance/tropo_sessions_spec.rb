require File.dirname(__FILE__) + '/acceptance_helper'

feature "Tropo Sessions", %q{
  In order to ...
  As a ...
  I want to ...
} do

  scenario "TropoSessions#create.json" do
    post tropo_sessions_path

    page.has_content?('Hello! Press 1 when your are ready to start crooning.')
    page.has_content?('ready_to_start')
    page.has_content?('/tropo/sessions/start_recording.json')
  end
end
