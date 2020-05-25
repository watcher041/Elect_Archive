
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1'　# S3バケット作成時に指定したリージョン。左記は東京を指す
    }
    config.fog_directory  = 'elect-archive' # 作成したS3バケット名
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/elect-archive'
  end
end