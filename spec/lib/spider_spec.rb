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
    lead = FactoryGirl.build(:lead)
    lead.layout('').class.should eq(Hash)
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

  describe Lead do
    before(:all) do
      @lead = FactoryGirl.build(:lead).extract
      @valid = FactoryGirl.build(:lead, :valid)
    end

    it "destroys bounced url" do
      bounce = FactoryGirl.create(:lead, :bounce)
      Lead.count.should eq(1)
      bounce.extract(true)
      Lead.count.should eq(0)
    end

    it "verifies lead url exists" do
      @lead.exists?.should be_true
    end

    it "crawls description from listing" do
      @lead.title.gsub(/:/, '').split.each do |field|
        @lead.content.should =~ /#{field}/i
      end
    end

    it "extracts information from lead" do
      @lead.company.should eq(@valid.company)
      @lead.location.should eq(@valid.location)
      @lead.site.should eq(@valid.site)
    end

    it "commits lead information" do
      lead = FactoryGirl.create(:lead)
      lead.extract
      Lead.where(:content => nil).count.should eq(1)
      lead.extract(true)
      Lead.where(:content => nil).count.should eq(0)
    end
  end
end