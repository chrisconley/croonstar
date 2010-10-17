class Song
  include Mongoid::Document

  field :lyrics
  field :url
  field :title
  field :artist
  references_many :croons
end