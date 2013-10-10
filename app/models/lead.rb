class Lead < ActiveRecord::Base
  include Spider

  attr_accessible :apply, :content, :company, :date, :digest, :feed_id, :location, :site, :title, :url

  belongs_to :feed
  validates_presence_of :date, :digest, :feed_id, :url
  validates_uniqueness_of :digest, :url

  def extract(commit=false)
    if exists?
      info = layout feed.fetch
      info.each do |field, val|
        send(field + '=', val)
      end
      if commit
        save
      end
      self
    elsif commit
      destroy
    end
  end
end
