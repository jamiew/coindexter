# encoding: utf-8

class LogoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # include CarrierWaveDirect::Uploader

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/assets/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  process resize_to_fill: [400,400]
  process crop: '400x400+0+0'

  version :small do
    process :crop
    process resize_to_fill: [60,60]
  end
  
  version :select_option do
    process resize_to_fill: [60,60]
  end

  attr_reader :width, :height
  before :cache, :capture_size_before_cache # callback, example here: http://goo.gl/9VGHI
  def capture_size_before_cache(new_file) 
    if version_name.blank? # Only do this once, to the original version
      if file.path.nil? # file sometimes is in memory
        img = ::MiniMagick::Image::read(file.file)
        @width = img[:width]
        @height = img[:height]
      else
        @width, @height = `identify -format "%wx %h" #{file.path}`.split(/x/).map{|dim| dim.to_i }
      end
    end
  end

  def crop
    if model.crop_x.present?
      resize_to_fit(400, 400)
      manipulate! do |img|
        # img = MiniMagick::Image.open(model.avatar.path)
        puts "img is #{img.inspect}"

        x = model.crop_x
        y = model.crop_y
        w = model.crop_w
        h = model.crop_h

        size = w << 'x' << h
        offset = '+' << x << '+' << y

        puts "size is #{size}"
        puts "offset is #{offset}"

        img.crop("#{size}#{offset}")
        img

      end
    end
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def validate_dimensions
    if file.path.nil? # file sometimes is in memory
        img = ::MiniMagick::Image::read(file.file)
        width = img[:width]
        height = img[:height]
      else
        width, height = `identify -format "%wx %h" #{file.path}`.split(/x/).map{|dim| dim.to_i }
    end
    return height == width
  end

  def resize_and_crop(size)  
    manipulate! do |image|                 
      if image[:width] < image[:height]
        image.resize("#{image[:height]}x#{image[:height]}") 
      elsif image[:width] > image[:height] 
        image.resize("#{image[:width]}x#{image[:width]}") 
      end
      image
    end
  end

end
