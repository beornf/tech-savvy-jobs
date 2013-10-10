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

  factory :lead do
    title "Condé Nast: Front End Engineer"
    url "https://jobs.37signals.com/jobs/13495"

    trait :bounce do
      url "http://careers.stackoverflow.com/jobs/39734/data-warehouse-engineer-amazon"
    end

    trait :valid do
      company "Condé Nast"
      location "New York"
      site "http://www.condenast.com/careers"
    end

    after(:build) do |lead|
      lead.feed = FactoryGirl.build(:feed)
      lead.feed.fetch = "content css=.listing-container, html
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