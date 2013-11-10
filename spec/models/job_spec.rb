require 'spec_helper'

describe Feed do
  before(:all) do
    @feed = FactoryGirl.build(:feed)
    @jobs = @feed.jobs
    @pos = 5
  end

  it "creates list of jobs" do
    @jobs.size.should be > @pos
  end

  it "passes model validation" do
    job = Job.new @jobs.first
    job.should be_valid
  end

  it "finds new jobs only" do
    Job.create @jobs[@pos]
    @feed.jobs.size.should eq(@pos)
  end

  it "crawls html feed" do
    pending "html feeds unimplemented"
    feed = FactoryGirl.build(:feed, :html)
    job = Job.new feed.jobs.first
    job.should be_valid
  end

  it "commits feed jobs" do
    @feed.save!
    @feed.crawl
    Job.count.should be > 1
    @feed.updated_at.should be > 1.minute.ago
  end
end