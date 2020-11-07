
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  #config.dropbox_access_token = Rails.application.dropbox_access_token
end