# encoding: utf-8

class RecordingUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  #Process files as they are uploaded:
  process :adjust_delay

  def adjust_delay
     #split into a file for each channel files
     tmp_path = current_path.gsub(/\/[^\/]+$/, '')

    `sox #{file.file} #{tmp_path}/left.wav remix 1`
    `sox #{file.file} #{tmp_path}/right.wav remix 2`

    # trim one of them
    `sox #{tmp_path}/left.wav #{tmp_path}/left-trimmed.wav trim 0:00.6`

    # merge the two channels
    `sox -m #{tmp_path}/right.wav #{tmp_path}/left-trimmed.wav #{file.file}`
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(wav mp3)
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "merged.mp3" if original_filename
  # end

end
