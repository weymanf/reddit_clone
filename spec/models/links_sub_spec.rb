require 'spec_helper'

describe LinksSub do
  describe "associations" do

    it { should belong_to :link }
    it { should belong_to :sub }
  end
end
