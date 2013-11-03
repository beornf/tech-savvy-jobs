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

  desc "Extract job fields"
  task :job => :environment do
    if id = ENV['JOB_ID']
      jobs = Job.where(:feed_id => Feed.where("fetch IS NOT NULL")).
        where(:id => id)
    else
      jobs = Job.where(:feed_id => Feed.where(:active => true))
      jobs = jobs.where(:content => nil) if ENV['FORCE'].nil?
    end
    Spider.visit(jobs).each { |t| t.extract(true) }
  end

  task :all => [:feed, :job]
end

desc "Scrape all job resources"
task :crawl => "crawl:all"