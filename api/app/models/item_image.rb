class ItemImage
  include ActiveModel::Model
  attr_accessor :filename, :image

  validates :filename, :image, presence: true

  def self.fetch_images(s3_client = AwsS3.new)
    s3_config = Rails.configuration.x.application[:aws][:project][:image_server][:s3]
    bucket = s3_config[:bucket]
    prefix = s3_config[:prefix][:item]
    cdn_domain = Rails.configuration.x.application[:cdn][:domain]

    s3_client
      .list_image_objects(bucket: bucket, prefix: prefix)
      .map { |object| object.merge(url: "#{cdn_domain}/#{object[:url]}") }
  end

  def upload(s3_client = AwsS3.new)
    s3_config = Rails.configuration.x.application[:aws][:project][:image_server][:s3]
    bucket = s3_config[:bucket]
    prefix = s3_config[:prefix][:item]

    saved_filepath = generate_filepath(prefix)
    raise_validation_error unless valid?
    File.open(image.path, 'rb') do |file|
      s3_client.upload(bucket: bucket, body: file, key: saved_filepath)
    end
  end

  private

  def validate_image_size
    errors.add(:image, 'のファイルサイズは10MB以下にしてください') if mini_magick_image.size > MAX_IMAGE_SIZE
  end

  def generate_filepath(prefix)
    saved_filename = Time.zone.now.strftime('%Y%m%d_%H%M%S%L') + '_' + SecureRandom.uuid + File.extname(filename)
    File.join(prefix, saved_filename)
  end
end
