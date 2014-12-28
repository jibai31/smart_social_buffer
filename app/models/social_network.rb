# encoding: utf-8
class SocialNetwork < ActiveRecord::Base
  scope :implemented, -> { where(implemented: true) }

  def self.twitter
    find_by_provider "twitter"
  end

  def self.facebook
    find_by_provider "facebook"
  end

  def self.linkedin
    find_by_provider "linkedin"
  end

  def self.google
    find_by_provider "google_oauth2"
  end

  def to_s
    name.capitalize
  end
end
