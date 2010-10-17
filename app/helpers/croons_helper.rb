module CroonsHelper

  def song_select_options(songs)
    options = []
    songs.each do |s|
      options << [ "#{s.title} by #{s.artist}", s.id ]
    end
    options
  end

  def display_status(status)
    case status
      when "calling" then
      when "hangup" then
      when "processing" then
        
    end
  end
end
