module CroonsHelper

  def song_select_options(songs)
    options = []
    songs.each do |s|
      options << [ "#{s.title} by #{s.artist}", s.id ]
    end
    options
  end

  def display_status(croon)
    exclamation = "Oh No!  "
    if croon.recording_filename
      "Click below to play your song!"
    else
      if croon.hangup
        case croon.status
          when "initialized" then
            exclamation + "Something unexpected happened!"
          when "calling" then
            exclamation + "The call was disconnected before the song started!"
          when "recording" then
            exclamation + "The call was disconnected before the song finished!  Be sure to either press '9' or wait for the song to end before hanging up."
          when "processing" then
            exclamation + "The call was disconnected before the song finished!  Be sure to either press '9' or wait for the song to end before hanging up."
          when "complete" then
            exclamation + "We were unable to process your file!  Please try again."
        end
      else
        case croon.status
          when "initialized" then
            "You should receive a phone call shortly if you haven't already!"
          when "calling" then
            "You should receive a phone call shortly if you haven't already!"
          when "recording" then
            "We're still recording.  You have great pipes!"
          when "processing" then
            "Congratulations!  You have submitted a song, but we haven't finished processing it.  Press 'Finish' again in a few seconds."
          when "complete" then
            exclamation + "We were unable to process your file!  Please try again."
        end
      end
    end
  end
end