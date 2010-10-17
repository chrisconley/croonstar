require File.dirname(__FILE__) + '/acceptance_helper'

feature "Creating And Viewing Croons", %q{
  In order to ...
  As a ...
  I want to ...
} do

  background do
    Factory(:song, :title => "My Sharona")
  end

  scenario "Creating a new croon" do
    AwesomeHTTP.stub!(:get)
    visit "/"

    page.should have_content("Votes")
    # save_and_open_page

    fill_in "Phone number", :with => "1234567890"
    select "My Sharona", :from => "Pick a Song!"

    click_button "Croon!"

    page.should have_content("Croon")
  end
end
