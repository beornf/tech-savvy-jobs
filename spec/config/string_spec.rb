require 'spec_helper'

describe String do
  before(:all) do
    @url = 'http://hnhiring.com/'
  end

  it "extracts url from html fragment" do
    fragment = '<h1>Hacker News</h1><a href="http://hnhiring.com">' +
      'Job Board</a>'
    fragment.hyperlink.should eq(@url)
  end

  it "selects second url from fragment" do
    fragment = '<a href="http://stackoverflow.com">Tech Help</a>' +
      '<a href="http://hnhiring.com/">Job Notices</a>'
    fragment.hyperlink(1).should eq(@url)
  end
end