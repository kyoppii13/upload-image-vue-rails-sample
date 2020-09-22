class AwsS3
  def initialize
    @client = Aws::S3::Client.new(
      region: 'us-east-1',
      access_key_id: Rails.application.credentials.aws[:access_key_id],
      secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    )
  end

  def upload(bucket:, body:, key:)
    @client.put_object(bucket: bucket, body: body, key: key)
  end
end
