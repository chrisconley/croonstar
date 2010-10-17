class Croon
  include Mongoid::Document

  mount_uploader :recording, RecordingUploader

  field :phone_number
  field :song_url
end