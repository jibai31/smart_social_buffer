require 'rails_helper'

describe Account do

  describe "create" do
    let(:user) { create(:user) }

    before(:each) do
      @valid_attr = {social_network_id: 1, uid: "123", user: user}
      @new_account = Account.new(@valid_attr)
    end

    it "requires a uid" do
      @new_account.uid = ""
      expect(@new_account).not_to be_valid
    end

    it "requires a social network" do
      @new_account.social_network_id = nil
      expect(@new_account).not_to be_valid
    end

    it "creates a Planning" do
      expect{ @new_account.save }.to change(Planning, :count).by(1)
    end
  end
end
