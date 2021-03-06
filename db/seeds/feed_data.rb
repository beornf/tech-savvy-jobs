# encoding: utf-8
# Autogenerated by the db:seed:dump task
# Do not hesitate to tweak this to your needs

Feed.create([
  { :active => true, :name => "Stack Overflow", :url => "http://careers.stackoverflow.com/jobs/feed", :fetch => "title css=#title\r\napply css=.apply; sub(/How to apply\\s*/, '')\r\ncontent css=.jobdetail, html\r\ncompany css=.employer\r\nlocation css=.location; split(/\\s*\\(/)[0]\r\nsite css=#hed, html; hyperlink(1)", :list => "", :newer => true, :rss => true },
  { :active => true, :name => "37signals", :url => "http://jobs.37signals.com/jobs.rss", :fetch => "title css=h1\r\napply css=.apply; sub(/Apply for this position\\s*/, '')\r\ncontent css=.listing-container, html\r\ncompany css=.company\r\nlocation css=.location; split(/:\\s*/)[1]\r\nsite css=.listing-header-container, html; hyperlink", :list => "", :newer => true, :rss => true },
  { :active => true, :name => "Ruby Now", :url => "http://feeds.feedburner.com/jobsrubynow?format=xml", :fetch => "title css=#headline; split(/\\s+at/)[0]\r\napply css=#instructions\r\ncontent css=#info, html\r\ncompany css=#headline a\r\nlocation css=#location\r\nsite css=#headline, html; hyperlink", :list => "", :newer => false, :rss => true },
  { :active => true, :name => "GitHub Jobs", :url => "https://jobs.github.com/positions.atom", :fetch => "title css=h1\r\napply css=.highlighted p\r\ncontent css=.main, html\r\ncompany css=.logo h2; split(/jobs\\s+/).last\r\nlocation css=.supertitle; split(/\\/\\s*/).last\r\nsite css=.logo, html; hyperlink", :list => "", :newer => true, :rss => true },
  { :active => false, :name => "Hacker News Jobs", :url => "http://hnhiring.com/", :fetch => nil, :list => nil, :newer => true, :rss => false },
  { :active => false, :name => "Authentic Jobs", :url => "http://www.authenticjobs.com/rss/custom.php?terms=&type=1,3", :fetch => nil, :list => nil, :newer => false, :rss => true },
  { :active => false, :name => "Smashing Jobs", :url => "http://jobs.smashingmagazine.com/rss/all/all", :fetch => nil, :list => nil, :newer => false, :rss => true }
])


