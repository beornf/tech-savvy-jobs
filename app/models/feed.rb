class Feed < ActiveRecord::Base
  attr_accessible :active, :hook, :list, :name, :newer,  :rss, :url, :view_count
  validates_presence_of :name, :url
  validates_uniqueness_of :url
end
