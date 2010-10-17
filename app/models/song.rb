class Song
  include Mongoid::Document

  field :lyrics
  field :url
  field :title
  field :artist
  references_many :croons

  def self.select_options
    options = []
    puts "hello?"
    all.each do |s|
      puts "object" 
      options << [ "#{s.title} by #{s.artist}", s.url ]
    end
    options
  end
end