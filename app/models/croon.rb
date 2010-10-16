class Croon
  include Mongoid::Document

  def before_validation_on_create
      self.phone_number = phone_number.gsub(/[^0-9]/, "")
   end

   validates_presence_of :phone_number
   validates_length_of :phone_number, :is => 10, :message => "must contain of 10 digits"

  field :phone_number
  field :song_url
end