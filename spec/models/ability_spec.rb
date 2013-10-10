require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  describe "rails admin rules" do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      @ability = Ability.new(admin)
    end

    it "allows dashboard access" do
      @ability.should be_able_to(:access, :rails_admin)
    end
  end
end