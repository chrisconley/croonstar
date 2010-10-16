require File.dirname(__FILE__) + '/acceptance_helper'

feature "Tropo Recordings", %q{
  In order to ...
  As a ...
  I want to ...
} do

  scenario "TropoRecordings#create" do
    @croon = Factory(:croon, :recording => nil)
    file = Rack::Test::UploadedFile.new(File.dirname(__FILE__) + '/support/foreword.mp3')
    page.driver.post "/tropo_recordings.json?croon_id=#{@croon.id}", :filename => file

    puts @croon.recording.inspect
    puts @croon.recording_filename.inspect
    @croon.recording.url.should == "hello"
  end
end
