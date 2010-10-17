module CroonsHelper

  def song_select_options(songs)
    options = []
    songs.each do |s|
      options << [ "#{s.title} by #{s.artist}", s.id ]
    end
    options
  end

  def display_status(croon)
    if croon.hangup
      exclamation = "Oh No!  "
      case croon.status
        when "initialized" then
          exclamation + "Something unexpected happened!  Try again."
        when "calling" then
          exclamation + "The call was disconnected before the song started!  If you want to try again, click the 'try again' button."
        when "recording" then
          exclamation + "The call was disconnected before the song finished!  You have to sing the entire song.  Be sure you have a good connection and wait for us to disconnect before you hangup."
        when "processing" then
          "Congratulations!  You have submitted a song.  The song should be available shortly"
        when "complete" then
          if croon.recording_filename
            "Click below to play your song!"
          else
            exclamation + "We were unable to process your file!  Please try again."
          end
      end
    else
      case croon.status
        when "initialized" then
          "You should receive a phone call shortly if you haven't already!  Follow the prompt and press '1' when you are ready to sing.  If you haven't received a call within a minute, please try again."
        when "calling" then
          "You should receive a phone call shortly if you haven't already!  Follow the prompt and press '1' when you are ready to sing.  If you haven't received a call within a minute, please try again."
        when "recording" then
          "You have great pipes!  Don't hang up until until we do!"
        when "processing" then
          "Congratulations!  You have submitted a song.  The song should be available shortly"
        when "complete" then
          "Click below to play your song!"
      end
    end
  end
end