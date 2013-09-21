namespace :scrape do
  desc "Scrape RSS feeds"
  task :feed => :environment do
    if id = ENV['ID']
      feeds = Feed.where(:id => id)
    else
      feeds = Feed.where(:active => true)
    end
    feeds.each { |f| f.scrape }
  end

  task :all => [:feed]
end

desc "Scrape all job resources"
task :scrape => "scrape:all"