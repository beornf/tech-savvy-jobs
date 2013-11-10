require 'spec_helper'

describe Spider do
  before(:all) do
    @pause = 0.4
    @pages = FactoryGirl.build_list(:page, 8)
    @chain = Spider::Chain.new @pause
  end

  it "extracts host from page url" do
    host = @pages.first.host
    host[/[a-z0-9.]+/].should eq(host)
  end

  it "crawls and returns hash" do
    job = FactoryGirl.build(:job)
    job.layout('').class.should eq(Hash)
  end

  it "stores pages in chain object" do
    @pages.each { |p| @chain << p }
    @pages.size.should eq(@chain.size)
  end

  it "produces digest from string" do
    Spider.digest("test").size.should eq(18)
  end

  it "pause between scraping one host" do
    hist = {}
    Spider.visit(@pages, @pause).each do |page|
      now = Time.now.to_f
      if hist.include? host = page.host
        hist[host].should be < @pause.second.ago.to_f
      end
      hist[host] = now - 0.001
    end
  end

  describe Job do
    before(:all) do
      @job = FactoryGirl.build(:job).extract
      @valid = FactoryGirl.build(:job, :valid)
    end

    it "destroys bounced url" do
      bounce = FactoryGirl.create(:job, :bounce)
      Job.count.should eq(1)
      bounce.extract(true)
      Job.count.should eq(0)
    end

    it "verifies job url exists" do
      @job.exists?.should be_true
    end

    it "crawls description from listing" do
      @job.title.gsub(/:/, '').split.each do |field|
        @job.content.should =~ /#{field}/i
      end
    end

    it "extracts information from job" do
      @job.company.should eq(@valid.company)
      @job.location.should eq(@valid.location)
      @job.site.should eq(@valid.site)
    end

    it "commits job information" do
      job = FactoryGirl.create(:job)
      job.extract
      Job.where(:content => nil).count.should eq(1)
      job.extract(true)
      Job.where(:content => nil).count.should eq(0)
    end
  end
end