# encoding: utf-8

class NetworkLogoUploader < CarrierWave::Uploader::Base

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

  # for image size validation
  # fetching dimensions in uploader, validating it in model
  # attr_reader :width, :height
  # before :cache, :capture_size
 
  process :resize_to_fit => [100, 100]

  version :thumb do
    process :crop
    resize_to_fill(100, 100)
  end

  version :large do
    resize_to_fit(400, 400)
  end

  version :small do
    resize_to_fit(60, 60)
  end
  
  version :select_option do
   resize_to_fit(60, 60)
  end

  def default_url
    "/assets/fallback/" + [version_name, "default.png"].compact.join('_')
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

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

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
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def crop
    if model.crop_x.present?
      resize_to_fit(400, 400)
      manipulate! do |img|

        x = model.crop_x
        y = model.crop_y
        w = model.crop_w
        h = model.crop_h

        size = w << 'x' << h
        offset = '+' << x << '+' << y

        img.crop("#{size}#{offset}")
        img

      end
    end
  end

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

  def extension_white_list
    %w(jpg jpeg gif png)
  end


end
