require 'spec_helper'

describe Admin do
  describe 'created in the database' do
    before(:each) do
      @admin = Admin.new :email => 'david@techsvvyjobs.com'
      @pass = 'nobody'
    end

    it "has a correct password" do
      @admin.password = @pass
      (@admin.valid_password? @pass).should be_true
    end
  end
end
