class Lead < ActiveRecord::Base
  include Spider

  attr_accessible :content, :date, :digest, :feed_id, :geo, :site, :title, :url

  belongs_to :feed
  validates_presence_of :date, :digest, :feed_id, :url
  validates_uniqueness_of :digest

  def extract

  end
end
