require 'feedzirra'

class Feed < ActiveRecord::Base
  attr_accessible :active, :fetch, :list, :name, :newer, :rss, :url

  validates_presence_of :name, :url
  validates_uniqueness_of :url

  def scrape
    if result = leads
      Lead.create result
      self.total += 1
      self.save
    end
  end

  def leads
    if self.newer or self.updated_at < 23.hours.ago
      @leads = []
      if self.rss then rss_leads else html_leads end
      @leads.each { |lead| lead[:feed_id] = self.id }
    else
      nil
    end
  end

  def rss_leads
    feed = Feedzirra::Feed.fetch_and_parse(self.url)
    feed.entries.each do |t|
      title, date, url = t.title, t.published, t.entry_id
      uniq = Spider.digest(title + date.to_s)
      if Lead.exists?(:digest => uniq); break end
      @leads << { :title => title, :date => date, :digest => uniq, :url => url }
    end
  end

  def html_leads

  end
end
