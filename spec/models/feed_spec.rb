require 'spec_helper'

describe Feed do
  before(:all) do
    @feed = FactoryGirl.build(:feed)
    @leads = @feed.leads
    @pos = 5
  end

  it "creates list of leads" do
    @leads.size.should be > @pos
  end

  it "passes model validation" do
    lead = Lead.new @leads.first
    lead.should be_valid
  end

  it "finds new leads only" do
    Lead.create @leads[@pos]
    @feed.leads.size.should eq(@pos)
  end

  it "crawls html feed" do
    pending "html feeds unimplemented"
    feed = FactoryGirl.build(:feed, :html)
    lead = Lead.new feed.leads.first
    lead.should be_valid
  end

  it "commits feed leads" do
    @feed.save!
    @feed.crawl
    Lead.count.should be > 1
    @feed.updated_at.should be > 1.minute.ago
  end
end
