namespace :crawl do
  desc "Crawl RSS feeds"
  task :feed => :environment do
    if id = ENV['FEED_ID']
      feeds = Feed.where(:id => id)
    else
      feeds = Feed.where(:active => true).where(
        "newer = ? OR updated_at < ?", true, 11.hours.ago)
    end
    feeds.each { |t| t.crawl }
  end

  desc "Extract lead fields"
  task :lead => :environment do
    if id = ENV['LEAD_ID']
      leads = Lead.where(:feed_id => Feed.where("fetch IS NOT NULL")).
        where(:id => id)
    else
      leads = Lead.where(:feed_id => Feed.where(:active => true))
      leads = leads.where(:content => nil) if ENV['FORCE'].nil?
    end
    Spider.visit(leads).each { |t| t.extract(true) }
  end

  task :all => [:feed, :lead]
end

desc "Scrape all job resources"
task :crawl => "crawl:all"