require 'spec/spec_helper'

describe Croon do
  it "should reference one song" do
    song = Factory(:song)
    croon = Factory(:croon, :song => song)
    croon.reload.song.should == song
  end
end