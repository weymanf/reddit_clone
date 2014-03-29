require 'spec_helper'

describe User do

  it "has a username" do
    testuser = FactoryGirl.build(:user, username: nil)
    expect(testuser).to_not be_valid
  end

  it "has a password to be nil or greater than 6 characters" do
    testuser = FactoryGirl.build(:user, password: "abcd")
    expect(testuser).to_not be_valid
  end

  it "password should also be valid as nil" do
    testuser = FactoryGirl.build(:user, password: nil)
    expect(testuser).to be_valid
  end

  describe "associations" do
    it { should have_many :subs }
    it { should have_many :links }
    it { should have_many :comments }
  end

  describe "methods" do

    it "should generate password digest" do
      testuser = FactoryGirl.build(:user)
      expect(testuser.password_digest).to_not be_nil
    end

    it "should check right password" do
      testuser = FactoryGirl.build(:user, password: "password")
      expect(testuser.is_password?("password")).to be_true
    end

    it "should have a session token" do
      testuser = FactoryGirl.create(:user)
      expect(testuser.session_token).to be_present
    end

    it "should reset session token" do
      testuser = FactoryGirl.create(:user)
      original = testuser.session_token
      testuser.reset_session_token!
      expect(testuser.session_token).to_not eq original
    end

    it "should return a user" do
      testuser = FactoryGirl.create(:user, password: "password", :username => "weyman")
      expect(User.find_by_credentials("weyman", "password")).to eq(testuser)
    end


  end

end
