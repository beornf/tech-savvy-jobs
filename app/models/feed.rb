require 'feedzirra'

class Feed < ActiveRecord::Base
  attr_accessible :active, :fetch, :list, :name, :newer, :rss, :url

  validates_presence_of :name, :url
  validates_uniqueness_of :url

  def crawl
    Lead.create leads
    self.count += 1
    save
  end

  def leads
    @leads = []
    if rss then rss_leads else html_leads end
    @leads.each { |lead| lead[:feed_id] = id }
  end

  def route(entry)
    entry.split('?').first
  end

  def rss_leads
    feed = Feedzirra::Feed.fetch_and_parse(url)
    feed.entries.each do |t|
      title, date, link = t.title, t.published, route(t.url)
      digest = Spider.digest(title + date.to_s)
      if Lead.exists?(["digest = ? OR url = ?", digest, link]); break end
      @leads << { :title => title, :date => date, :digest => digest,
        :url => link }
    end
  end

  def html_leads

  end
end
