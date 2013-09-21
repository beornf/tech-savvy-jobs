require 'spec_helper'

describe Feed do
  before(:all) do
    @feed = FactoryGirl.build(:feed)
    @past = FactoryGirl.build(:feed, :past)
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
    @feed.leads.size.should == @pos
  end

  it "ignores older feed" do
    @past.leads.should be_nil
  end

  it "scrapes html feed" do
    pending "html feeds unimplemented"
    feed = FactoryGirl.build(:feed, :html)
    lead = Lead.new feed.leads.first
    lead.should be_valid
  end

  it "commits feed leads" do
    @feed.save!
    @feed.scrape
    Lead.count.should be > 1
    @feed.updated_at.should be > 1.minute.ago
  end

  it "leaves older feed" do
    @past.save!
    @past.scrape
    @past.updated_at.should be < 1.hours.ago
  end
end
