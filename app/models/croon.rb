class Croon
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :recording, RecordingUploader

  validates_presence_of :phone_number
  validates_length_of :phone_number, :is => 10, :message => "must contain 10 digits"
  before_save :truncate_and_immute_crooner

  field :phone_number
  field :vote_count, :type => Integer, :default => 0
  field :crooner
  field :status, :default => "initialized"
  field :hangup, :type => Boolean
  referenced_in :song

  def truncate_and_immute_crooner()
    puts "was " + self.crooner_was
    puts "new " + self.crooner
    if self.crooner_was.present?
      self.crooner = self.crooner_was
    else
      self.crooner = self.crooner.try(:first, 25)
    end
  end

  def song_attributes=(song_attributes)
    self.song = Song.criteria.id(song_attributes[:id]).first
  end

  def before_validation_on_create
    self.phone_number = phone_number.gsub(/[^0-9]/, "")
  end
end