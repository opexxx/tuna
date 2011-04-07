class FingerprintMatch < ActiveRecord::Base
  belongs_to :email
  belongs_to :fingerprint
end
