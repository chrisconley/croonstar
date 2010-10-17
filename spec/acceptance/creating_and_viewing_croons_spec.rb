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

    page.should have_content("Most Popular")
    # save_and_open_page

    select "My Sharona", :from => "1. Select a Song"
    fill_in "2. Tell us where to call you", :with => "1234567890"

    click_button "Get Your Croon On"

    page.should have_content("Croon")
  end

  scenario "Viewing a croon" do
    croon = Factory.create(:croon)
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_content("should receive a phone call")
    page.should have_content("Follow the prompt")
    page.should have_content("haven't received a call within a minute")
  end
end
