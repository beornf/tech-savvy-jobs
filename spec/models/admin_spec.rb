require 'spec_helper'

describe Admin do
  describe 'created in the database' do
    before(:each) do
      @admin = FactoryGirl.create(:admin)
      @pass = 'secret'
    end

    it "has a correct password" do
      @admin.password = @pass
      (@admin.valid_password? @pass).should be_true
    end
  end
end
