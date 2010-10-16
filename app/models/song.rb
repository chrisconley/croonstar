class Song
  include MongoMapper::Document

  key :lyrics
  key :url
  key :title
end