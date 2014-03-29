require 'spec_helper'

describe Link do

  describe "validations" do

    it "should have a title" do
      link = FactoryGirl.build(:link, :title => nil)
      expect(link).to_not be_valid
    end

    it "should have a url"  do
      link = FactoryGirl.build(:link, :url => nil)
      expect(link).to_not be_valid
    end


  end

  describe "association" do

    it { should have_many :links_subs }
    it { should have_many :subs }
    it { should belong_to :user }
    it { should have_many :comments }

  end


end
