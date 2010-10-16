class Song
  include Mongoid::Document

  key :lyrics
  key :url
  key :title
end