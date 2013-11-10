require 'feedzirra'

class Feed < ActiveRecord::Base
  attr_accessible :active, :fetch, :list, :name, :newer, :rss, :url

  validates_presence_of :name, :url
  validates_uniqueness_of :url

  def crawl
    Job.create jobs
    self.count += 1
    save
  end

  def jobs
    @jobs = []
    if rss then rss_jobs else html_jobs end
    @jobs.each { |job| job[:feed_id] = id }
  end

  def route(entry)
    entry.split('?').first
  end

  def rss_jobs
    feed = Feedzirra::Feed.fetch_and_parse(url)
    feed.entries.each do |t|
      title, date, link = t.title, t.published, route(t.url)
      digest = Spider.digest(title + date.to_s)
      if Job.exists?(["digest = ? OR url = ?", digest, link]); break end
      @jobs << { :title => title, :date => date, :digest => digest,
        :url => link }
    end
  end

  def html_jobs

  end
end
