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

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      long_url: long_url,
      short_url: ShortenedUrl.random_code,
      submitter_id: user.id
    )
  end

  def self.random_code
    loop do
      short_code = SecureRandom.urlsafe_base64(16)
      return short_code unless exists?(short_url: short_code)
    end
  end

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )
end
