require 'spec_helper'

describe Sub do

  describe "validations" do

    it "should have have name" do
      sub = FactoryGirl.build(:sub)
      expect(sub.name).to be_present
    end

    it "should be invalid without a name" do
      sub = FactoryGirl.build(:sub, name: nil)
      expect(sub).to_not be_valid
    end



  end


  describe "associations" do
    it { should belong_to :moderator }
    it { should have_many :links_subs }
    it { should have_many :links }
  end
end
