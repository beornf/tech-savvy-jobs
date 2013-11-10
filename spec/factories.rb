require 'factory_girl'
require 'random_data'

FactoryGirl.define do
  factory :admin do
    email "david@techsavvyjobs.com"
    password "tester123"
  end

  factory :feed do
    id 1
    name "37signals"
    url "http://jobs.37signals.com/jobs.rss"
    newer true
    rss true
    updated_at 4.hours.ago

    trait :html do
      url "http://hnhiring.com/"
      rss false
    end
  end

  factory :job do
    title "Data Engineer"
    url "https://jobs.37signals.com/jobs/13658"

    trait :bounce do
      url "http://careers.stackoverflow.com/jobs/39734/data-warehouse-engineer-amazon"
    end

    trait :valid do
      company "Harvest Exchange"
      location "Chicago, IL"
      site "http://www.hvst.com/"
    end

    after(:build) do |job|
      job.feed = FactoryGirl.build(:feed)
      job.feed.fetch = "content css=.listing-container, html
        company css=.company
        location css=.location; split(':')[1].strip
        site css=.listing-header-container, html; hyperlink"
    end

    date Time.now
    digest Spider.digest("tester123")
  end

  factory :page do
    url do
      ["https://jobs.37signals.com/", "http://feedproxy.google.com/~r/",
       "http://www.crunchboard.com/"].sample + Random.alphanumeric + ".html"
    end
  end
end