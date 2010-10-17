Factory.define :croon do |f|
  f.phone_number '1234567890'
  f.song_url "/test.mp3"
end

Factory.define :song do |f|
  f.title "My Sharona"
  f.url "/test.mp3"
end