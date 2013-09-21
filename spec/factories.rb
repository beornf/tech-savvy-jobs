require 'factory_girl'
require 'random_data'

FactoryGirl.define do
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

    trait :past do
      newer false
    end
  end

  factory :lead do
    feed
    title "onPeak: Software Developer"
    url "https://jobs.37signals.com/jobs/13496"

    trait :scrape do
      after(:build) do |lead|
        lead.fetch = "<span container></span>"
      end
    end
  end

  factory :page do
    url do
      ["https://jobs.37signals.com/", "http://feedproxy.google.com/~r/",
       "http://www.crunchboard.com/"].sample + Random.alphanumeric + ".html"
    end
  end
end