require 'carrierwave/orm/mongo_mapper'

class Croon
  include MongoMapper::Document
  extend CarrierWave::MongoMapper

  mount_uploader :recording, RecordingUploader

  key :phone_number
  key :song_url
end