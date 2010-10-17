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

  scenario "Viewing a croon with initialized status" do
    croon = Factory.create(:croon)
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_button("Finish")
    page.should have_content("should receive a phone call")
  end

  scenario "Viewing a croon with calling status" do
    croon = Factory.create(:croon, :status => "calling")
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_button("Finish")
    page.should have_content("should receive a phone call")
  end

  scenario "Viewing a croon with recording status" do
    croon = Factory.create(:croon, :status => "recording")
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_button("Finish")
    page.should have_content("still recording")
  end

  scenario "Viewing a croon with processing status" do
    croon = Factory.create(:croon, :status => "processing")
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_button("Finish")
    page.should have_content("processing")
  end

  scenario "Viewing a croon with initialized status that has been hungup" do
    croon = Factory.create(:croon, :status => "initialized", :hangup => true)
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_content("Oh No!")
    page.should have_content("unexpected")
  end

  scenario "Viewing a croon with calling status that has been hungup" do
    croon = Factory.create(:croon, :status => "calling", :hangup => true)
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_content("Oh No!")
    page.should have_content("disconnected before")
  end

  scenario "Viewing a croon with recording status that has been hungup" do
    croon = Factory.create(:croon, :status => "recording", :hangup => true)
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_content("Oh No!")
    page.should have_content("disconnected before")
    page.should have_content("wait")
  end

  scenario "Viewing a croon with processing status that has been hungup" do
    croon = Factory.create(:croon, :status => "processing", :hangup => true)
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_content("disconnected")
  end

  scenario "Viewing a croon with a recording" do
    croon = Factory.create(:croon, :status => "complete", :recording_filename => "not_nil")
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_content("play your song")
  end

  scenario "Viewing a croon with complete status that has been hungup and has a recording" do
    croon = Factory.create(:croon, :status => "complete", :hangup => true, :recording_filename => "not_nil")
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_content("play your song")
  end

  scenario "Viewing a croon with complete status that has been hungup and has no recording" do
    croon = Factory.create(:croon, :status => "complete", :hangup => true)
    AwesomeHTTP.stub!(:get)
    visit "/croons/#{croon.id}"

    page.should have_button("Try Again")
    page.should have_content("unable to process")
  end
end
