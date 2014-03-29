require 'spec_helper'

describe Comment do
  describe "associations" do
    it { should have_many :replies }
    it { should belong_to :link }
    it { should belong_to :user }
  end

  describe "validations" do
    it "should be valid with content" do
      comment = FactoryGirl.build(:comment)

      expect(comment).to be_valid
    end
  end
end
