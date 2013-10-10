require 'spec_helper'

describe ApplicationHelper do
  describe "missing method" do
    it "should raise error" do
      expect {missing}.to raise_error
    end
  end

  describe "nav links" do
    before(:all) do
      base = Class.new do
        include ApplicationHelper
        include ActionView::Helpers
        include Rails.application.routes.url_helpers

        def initialize(path)
          (class << self; self; end).class_eval do
            define_method :request do
              Class.new { eval "def fullpath; '#{path}'; end" }.new
            end
          end
        end
      end
      links = {about: '/about', root: '/', jobs: '/jobs', post: '/post'}
      first = true
      links.each do |name, path|
        if first
          method = "=nav_links({about: 'About', jobs: 'Jobs'}, false)"
          first = false
        else
          method = "= nav_links({root: 'Welcome', jobs: 'Jobs'})"
        end
        instance_variable_set("@#{name.to_s}",
          Nokogiri::HTML::DocumentFragment.parse(
          (Haml::Engine.new method).render(base.new path)))
      end
    end

    def parent(node)
      node.first.parent.attributes['class'].value
    end

    it "creates link footer" do
      @about.css('a').count.should eq(2)
    end

    it "creates list of links" do
      @root.css('li').count.should eq(2)
      @root.css('a').first.content.should eq('Welcome')
    end

    it "links to root index" do
      link = @root.css('a[href="/"]')
      link.count.should eq(1)
      parent(link).should eq('selected')
    end

    it "selects job list item" do
      parent(@jobs.css('a[href="/jobs"]')).should eq('selected')
    end

    it "selects no list items" do
      @post.css('li.selected').count.should eq(0)
    end
  end

  describe "page title" do
    before(:all) do
      @name = 'About Us'
    end

    it "includes the page title" do
      page_title(@name).should match(@name)
    end

    it "includes the site title" do
      page_title(@name).should match(Settings.title)
    end

    it "creates default site title" do
      page_title('').should match(Settings.title)
    end
  end

  describe "short title" do
    before(:all) do
      @title = 'iOS Developer'
    end

    it "removes text after symbol" do
      amazon = "#{@title} - Amazon"
      google = "#{@title} @ Google"
      short_title(amazon).should eq(@title)
      short_title(google).should eq(@title)
    end

    it "leaves normal title" do
      short_title(@title).should eq(@title)
    end
  end

  describe "summary" do
    it "extracts paragraph description" do
      text = "<div><h1>Software Engineer</h1><p>Walking Thumbs’ mission: To transform the way people interact...</p></div>"
      summary(text).should match(/^Walking Thumbs/)
    end

    it "extracts first sentence" do
      text = "<h1>Sr. Software Engineer</h1><p>Our group is comprised of software engineers, math specialists...</p>"
      summary(text).should match(/^Our group is/)
    end
  end
end