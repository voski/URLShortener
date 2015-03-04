# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string           not null
#  short_url    :string
#  submitter_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, presence: true
  validates :long_url, presence: true
  validates :short_url, uniqueness: true

  def self.random_code
    loop do
      short_code = SecureRandom.urlsafe_base64(16)
      return short_code unless exists?(short_url: short_code) 
    end
  end
end
