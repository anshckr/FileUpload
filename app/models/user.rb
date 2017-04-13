class User < ApplicationRecord
  has_secure_password

  has_many :attachments
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
